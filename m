Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F2C3A4090
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 12:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhFKK5k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 06:57:40 -0400
Received: from a4-3.smtp-out.eu-west-1.amazonses.com ([54.240.4.3]:56589 "EHLO
        a4-3.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230349AbhFKK53 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 06:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1623408930;
        h=Subject:References:To:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=JQSar8pNVL8uNMmtndMDXJNhwT0qKZduYxN8VtlmcsA=;
        b=J2weiGNsRv8nhoNFy7/z4eOFepS5xnj9eQAMrQG7L6UZ4ZpLF9YuADMq5T49BVPD
        IsrslH9IBZ+/19zYDtIg/Yk3n6tXdxiKpt0ASRFvLPj7X2FyDthbVQ2Uoa+Ktc6iEAG
        QCo9AYTi36qzCtslo68YEPIScmowVvkpgQYuoqRQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1623408930;
        h=Subject:References:To:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=JQSar8pNVL8uNMmtndMDXJNhwT0qKZduYxN8VtlmcsA=;
        b=DnyhtaEOZBqEgZpQhxMmGJpEMZn2EGTG/aCaK6na6fuX+iibAnuof+yJQOY0s+bw
        RmoKLt4ajuQrEm2+GblLQEpVFJJzSMSgi9A+fv3gyzmQFI8Z6DJnlILb5re46+BXX7E
        10JrOX0MuKVEJ6i1u8H5y+zo+2716P5cogVwtmXI=
Subject: Re: Combining nodatasum + compression
References: <01020179f656e348-b07c8001-7b74-432a-b215-ccc7b17fbfdf-000000@eu-west-1.amazonses.com>
 <80834345-2626-a0a9-c3ae-fb2cc9435b49@gmx.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <01020179fab66f82-98bc2232-7461-42ea-8194-ec5d1670d9f6-000000@eu-west-1.amazonses.com>
Date:   Fri, 11 Jun 2021 10:55:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <80834345-2626-a0a9-c3ae-fb2cc9435b49@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.06.11-54.240.4.3
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11.06.2021 02:18 Qu Wenruo wrote:
> On 2021/6/10 下午10:32, Martin Raiber wrote:
>> when btrfs is running on a block device that improves integrity (e.g.
>> Ceph), it's usefull to run it with nodatasum to reduce the amount of
>> metadata and random IO.
>>
>> In that case it would also be useful to be able to run it with
>> compression combined with nodatasum as well.
>>
>> I actually found that if nodatasum is specified after compress-force,
>> that it doesn't remove reset the compress/nodatasum bit, while the other
>> way around it doesn't work.
>>
>> That combined with
>>
>> --- linux-5.10.39/fs/btrfs/inode.c.orig 2021-05-31 16:11:03.537017580 
>> +0200
>> +++ linux-5.10.39/fs/btrfs/inode.c      2021-05-31 16:11:19.461591523 
>> +0200
>> @@ -408,8 +408,7 @@
>>    */
>>   static inline bool inode_can_compress(struct btrfs_inode *inode)
>>   {
>> -       if (inode->flags & BTRFS_INODE_NODATACOW ||
>> -           inode->flags & BTRFS_INODE_NODATASUM)
>> +       if (inode->flags & BTRFS_INODE_NODATACOW)
>>                  return false;
>>          return true;
>>   }
>>
>> should do the trick. >
>> The above code was added with the argument that having no checksums with
>> compression would damage too much data in case of corruption (
>> https://lore.kernel.org/linux-btrfs/20180515073622.18732-2-wqu@suse.com/
>> ).
>
> It doesn't make a difference whether it's a single device fs or not.
> If we don't have csum, the corruption is not only affecting the sector
> where the corruption is, but the full compressed extent.
Doesn't really matter if it doesn't happen if btrfs is on a e.g. ceph 
volume. Furthermore it depends on the use-case if corruption affecting 
one page, or a whole compressed block is something one can live with.
>
> Furthermore, it's not that simple.
>
> Current code we always expect compressed read to find some csum.
> Just check btrfs_submit_compressed_read(), it will call
> btrfs_lookup_bio_sums().
> Which will fill the csum array with 0 if it can not find any csum.

It seems to make that conditional w.r.t. BTRFS_INODE_NODATASUM

if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
     ret = btrfs_lookup_bio_sums(inode, comp_bio, (u64)-1, sums);
     BUG_ON(ret); /* -ENOMEM */
}and in check_compressed_csum: if (inode->flags & BTRFS_INODE_NODATASUM) 
return 0; This seems to have been moved around recently ( 
https://github.com/torvalds/linux/commit/334c16d82cfe180f7b262a6f8ae2d9379f032b18 
).

>
> Then at endio callbacks, we verify the csum against the data we read, if
> it's all zero, the csum will definitely mismatch and discard the data no
> matter if it's correct or not.
>
> The same thing applies to btrfs_submit_compressed_write(), it will
> always generate csum.

Same here:

int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;

...

if (!skip_sum) {
         ret = btrfs_csum_one_bio(inode, bio, start, 1);
         BUG_ON(ret); /* -ENOMEM */
  }

>
> The diff will just give you a false sense of compression without csum.
> It will still generate csum for write and relies on csum check at read 
> time.
>


