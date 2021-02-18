Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F2631E396
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 01:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhBRA4a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 19:56:30 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:43610 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBRA43 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 19:56:29 -0500
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 896F16C006DB;
        Thu, 18 Feb 2021 02:55:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1613609742; bh=zXL2WE3KCoOgJ4ejOCFkqeXIXSuEumToXp4cs4gV3WE=;
        h=References:From:To:Cc:Subject:In-reply-to:Date;
        b=HCN8l8gjxcAlK5dm+Y1JVcKElvYb0VeIZpKstOtAagn/wYEgxOq72wrkTre0ijrKx
         MPrWNrxuOlhw/8fDLi6E1CpDSoTJYb+ISHr8eI5Jep0a7RAB5MZ9+4GSUlUapAjKI1
         wNQKS7sd4d1viJeG3XEyCnMqdJ6g5mOGIk/PHPCc=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 7C7A26C006D2;
        Thu, 18 Feb 2021 02:55:42 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id JzJ3HziqnqVg; Thu, 18 Feb 2021 02:55:42 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id E6FA56C006CC;
        Thu, 18 Feb 2021 02:55:41 +0200 (EET)
Received: from nas (unknown [153.127.9.202])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 832A71BE00CE;
        Thu, 18 Feb 2021 02:55:39 +0200 (EET)
References: <20210215092011.6079-1-l@damenly.su>
 <20210217221852.GA1689899@devbig008.ftw2.facebook.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, nborisov@suse.com, dsterba@suse.cz
Subject: Re: [PATCH RFC] btrfs-progs: check: continue to check space cache
 if sb cache_generation is 0
In-reply-to: <20210217221852.GA1689899@devbig008.ftw2.facebook.com>
Message-ID: <o8giqjng.fsf@damenly.su>
Date:   Thu, 18 Feb 2021 08:55:31 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 885mlY9NBD+mjUCoXXneBxpE3CczPPGHiOq+zH8tkXr8MS+GdksMVBar7hJ7DSP4og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Thu 18 Feb 2021 at 06:18, Boris Burkov <boris@bur.io> wrote:

> On Mon, Feb 15, 2021 at 05:20:11PM +0800, Su Yue wrote:
>> User reported that test fsck-tests/037-freespacetree-repair 
>> fails:
>>  # TEST=037\* ./fsck-tests.sh
>>     [TEST/fsck]   037-freespacetree-repair
>> btrfs check should have detected corruption
>> test failed for case 037-freespacetree-repair
>>
>> The test tries to corrupt FST, call btrfs check readonly then 
>> repair FST
>> using btrfs check. Above case failed at the second readonly 
>> check steup.
>> Test log said "cache and super generation don't match, space 
>> cache will
>> be invalidated" which is printed by 
>> validate_free_space_cache().
>> If cache_generation of the superblock is not -1ULL,
>> validate_free_space_cache() requires that cache_generation must 
>> equal
>> to the superblock's generation. Otherwise, it skips the check 
>> of space
>> cache(v1, v2) like the above case where the sb cache_generation 
>> is 0.
>>
>> Since kernel commit 948462294577 ("btrfs: keep sb 
>> cache_generation
>> consistent with space_cache"), sb cache_generation will be set 
>> to be 0
>> once space cache v1 is disabled(nospace_cache/space_cache=v2).
>>
>> Fix it by adding the condition if sb cache_generation is 0 in
>> validate_free_space_cache() as it's valid now since the kernel 
>> commit
>> mentioned above.
>
> Sorry that I didn't notice the fsck issue.
> The fix looks good to me.
>
>>
>> Link: https://github.com/kdave/btrfs-progs/issues/338
>> Signed-off-by: Su Yue <l@damenly.su>
> Reviewed-by: Boris Burkov <boris@bur.io>
>>
>> ---
>> Hi, while reading free space cache v1 related code, I am 
>> (still)
>> confused about the value meanings of cache_generation in sb.
>>
>> For outdated space cache v1, cache_gen < sb gen.
>> For valid space cache v1, cache_gen == sb gen.
>> AS for values 0 and (u64)-1, many places use (u64)-1 to 
>> represent
>> cleared v1 caches. The only three places setting cache_gen to 0 
>> are
>> 1)  above kernel commit 948462294577.
>> 2)  kernel btrfs_parse_options() while mounting zoned device.
>> 3)  progs image/main.c:1147 while restoring image.
>>
>> I'm wondering whether loosing check condition in this patch is 
>> correct
>> or not. So make it RFC. Thanks.
>
> I did some archaeology on this, because when I wrote the patch 
> that
> broke this, I was sure that 0 meant "no space cache" and 
> couldn't
> actually answer your question without digging in.
>
> I believe that the situation is as follows:
>
> In the kernel code, super_cache_gen == 0 <-> no space cache. 
> This has
> been true since the introduction of the field in
> '0af3d00bad38 Btrfs: create special free space cache inode'.
> Another interesting kernel patch to note is:
> '73bc187680f9 Btrfs: introduce mount option no_space_cache'
> which explicitly mentions the check against super_cache_gen==0.
>
> However, in btrfs-progs, as you have correctly pointed out, 
> (u64)-1 is
> the sentinel value of interest. The reason is that in the 
> original
> free-space-cache mkfs patch:
> 'e2a6859d9325 Btrfs-progs: update super fields for space cache'
> -1 is used intentionally as a non-zero value to make space cache 
> the
> default setting. Quoting the patch:
> "It also makes us set it to -1 on mkfs so any new filesystem 
> will get
> the space cache stuff turned on"
> This was incompatible with the original check code which would 
> fail on
> freshly mkfs'd fses, which was fixed in:
> b4f4473e8a888 'Btrfs-progs: don't output baffling message when 
> checking
> a fresh fs'
>

Thanks for your detailed explanation! It's historical indeed.

> So tl;dr:
> in the kernel: 0 means no cache, only became consistent with
> nospace_cache recently, which broke fsck
> in progs: 0 still means no cache, -1 is a sentinel in mkfs to 
> force the
> first transaction to set it to the real generation value. -1 was 
> added
> to the fsck for fresh fses, but the 0 case never came up until 
> now.
>
That makes sense.

Thanks,
Su
> Thanks for looking into this and sending a fix,
> Boris
>> ---
>>  check/main.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/check/main.c b/check/main.c
>> index c7c5408bea19..a652e445de90 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -9951,7 +9951,12 @@ static int 
>> validate_free_space_cache(struct btrfs_root *root)
>>  {
>>  	int ret;
>>
>> +	/*
>> +	 * If cache generation is between 0 and -1ULL, sb 
>> generation must equal to
>> +	 *   sb cache generation or the v1 space caches are 
>> outdated.
>> +	 */
>>  	if (btrfs_super_cache_generation(gfs_info->super_copy) != 
>>  -1ULL &&
>> +	    btrfs_super_cache_generation(gfs_info->super_copy) != 
>> 0 &&
>>  	    btrfs_super_generation(gfs_info->super_copy) !=
>>  	    btrfs_super_cache_generation(gfs_info->super_copy)) {
>>  		printf(
>> --
>> 2.30.0
>>

