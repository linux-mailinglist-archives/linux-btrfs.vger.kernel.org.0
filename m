Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E28D483947
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jan 2022 00:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiACXoS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 18:44:18 -0500
Received: from mout.gmx.net ([212.227.15.18]:58619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbiACXoS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jan 2022 18:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641253455;
        bh=/Pbj4mjx/XO4BLKd2XedWbCpCEm5MAIAuYxGBQ7vjtI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=aCypTVavDmyOiMTXPIaBTA/huLSLJbzu63A130zEbXPqfGW2vw703b4xwewKxexoY
         3KT9f6dknDvg0GbKOGGrKKKkPXNbWVfVqES+/UPM0YmDHfKRltW/yLpood0WKkDo0X
         WkFjau+JDLQ7QCb/VccdRFjLQyMPDoFkpr8oNmIM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mwfai-1mAvH21qP4-00yD6c; Tue, 04
 Jan 2022 00:44:15 +0100
Message-ID: <0f234a85-313f-8d17-3315-f6193f6c7a15@gmx.com>
Date:   Tue, 4 Jan 2022 07:44:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH RFC 3/4] btrfs: introduce dedicated helper to scrub
 simple-stripe based range
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20211221023349.27696-1-wqu@suse.com>
 <20211221023349.27696-4-wqu@suse.com>
 <YdMlVbcZ0EdjwqWr@localhost.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YdMlVbcZ0EdjwqWr@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KfE/QovY1iYQ3OlcTbi2P7glQCnri5V79rZL6E3WafFY70TVayq
 hImyPJG0SK21vQMzxh8GEMilZjvLL5bfzaVX5dzXFC70GBTo8uIPGYAv91WG/leUPqqOT8B
 QTWW2dgwvV0djhxMRvcqjzYUEdc6TkBPpY5bDLJ+u2RmlRUzxKxZ3KK3P4cx3GzA17Z4UgO
 C/YBvfyU9Gji6+cR0+n3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nu7YF2GvNfY=:+9jBfgH0dWdHpXTlw0m5jf
 K5Ts2qXwAf2Nb4UYvTW0S+ORDEQ3WC9n6DKWdVwRfnezhg+p0J+hE8WiCi2ZoZeyvic15Qnxx
 dJ8oNVbbQYPstXlgOHFAD7PFYOd5p7hNJ83jRpICu+XlNWMCEGI12tKC0DCdxa5kc+vcgz9rt
 e/8cTeG3Dkd2qtnDiImr8mwAUSDP39fYpz6ddnX8erpWpciBG2dbX+c14VR57Gr1S9VctbOSF
 qURpy/ka5oH1xE8lz51EXiq3XFVwaDHtno4TfMTc8WiY0udAaZsZFxm2cONGNs3GYYYS7SqbQ
 5fPpOk0C0SgRu9SLPFZDEWGC6oPe6VmRp+GP6Il/98aYz6vDR1BSYX3uHpQ941eStfDTVdnof
 /WHZWJIyxGZmOaELkR8hFj16zY9qgpPRzKwo0CiZ/WoZ7Ru3u67/LNhf9tvvdUWktoTObLLby
 T0sGlZRTruztx0Qf20uY9Q9qGmfc6DOLp4DjYKKbznGA064XQHT96rjZ2rQPk2gEU/ssxZQw/
 zT9k8WjIx3KZDv0QQVusFuz6qFgpGMkULqdfmhrBcPS7p6o4HKwRiFhHzfhfELo8cLIFYz55i
 /F48w5NApZ1PNn7z/smIJ91Vc48U1C+dEM7/dbSCOZ7i/ILKO11SSa3unTneFhtKqVPqoPa70
 UIm542UBI8CQCL693FX7AwP7WVugl9ohGA6h6VQ3LXJ1XdLM4tAwXjGPwUZ2UeQvN9zMOyOkf
 NqIMm7uVMPoO+pxvB03daJsn1Vng3/1zG8abG5qazPPH4MBbZhrqbZETQJ8xEeFzXbzYUs7FG
 9kCx7TmaYu+WQXP8ApDQlE49Sfu1yk1SPgZLXWtxd/AyBwLPwaI7ghH0IHbYgNL7rXQsQ0vm5
 FtK8gR/n/lVkd93CnU8pZZ3faOdEBSglChKfpCXOzjclpichv+LUDMwpt6nKop8Lg8wUcIGnB
 SW1LVwCuqLk9AqBSNH8TAcSoaw/9cXe1BED6eGqk1gXVp8G7/5p3bVR6NDn6cfPH0c8sWBhxv
 qNA4M1L0P7WePPVVT23itxK0+a69fHsisIYAuwRqED1p/g69vfSF3saYxUGPIP3Y84Hc7N0Uc
 J4w+M1ZDzGgM6I=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/4 00:33, Josef Bacik wrote:
> On Tue, Dec 21, 2021 at 10:33:48AM +0800, Qu Wenruo wrote:
>> The new entrance will iterate through each data stripe which belongs to
>> the target device.
>>
>> And since inside each data stripe, RAID0 is just SINGLE, while RAID10 i=
s
>> just RAID1, we can reuse scrub_simple_mirror() to do the scrub properly=
.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/scrub.c | 60 +++++++++++++++++++++++++++++++++++++++++++++--=
-
>>   1 file changed, 57 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index ddd069bd2375..aff9db6fbc7e 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -3446,6 +3446,55 @@ static int scrub_simple_mirror(struct scrub_ctx =
*sctx,
>>   	return ret;
>>   }
>>
>> +static int scrub_simple_stripe(struct scrub_ctx *sctx,
>> +				struct btrfs_root *extent_root,
>> +				struct btrfs_root *csum_root,
>> +				struct btrfs_block_group *bg,
>> +				struct map_lookup *map,
>> +				struct btrfs_device *device,
>> +				int stripe_index)
>> +{
>> +	/* The increment of logical bytenr */
>> +	const u64 logical_increment =3D (map->num_stripes / map->sub_stripes)=
 *
>> +				      map->stripe_len;
>> +	/*
>> +	 * Our starting logical bytenr needs to be calculated based on
>> +	 * stripe_index.
>> +	 *
>> +	 * stripe_index / sub_stripes gives how many data stripes we need to
>> +	 * skip.
>> +	 */
>> +	const u64 orig_logical =3D (stripe_index / map->sub_stripes) *
>> +				 map->stripe_len + bg->start;
>> +	const u64 orig_physical =3D map->stripes[stripe_index].physical;
>> +	/*
>> +	 * For RAID0, it's fixed to 1.
>> +	 * For RAID10, the mirror_num is always 0,1,0,1,...
>> +	 */
>> +	const int mirror_num =3D stripe_index % map->sub_stripes + 1;
>
> For me I don't like having big comment blocks in the variable declaratio=
n part,
> it makes it hard to read.
>
> Also we have this sort of map math in a variety of different places.  If=
 it's
> complex enough that it needs a comment then I think it would be good to =
have
> static inline helpers with the math required to get the information we w=
ant,
> which comments that exist there.  Probably not needed for every little p=
eice of
> math, but for the common ones we do all the time it would be good.

That makes sense.

Some helpers would definitely makes more sense.

Thanks,
Qu
>
> If it doesn't make sense for any of the above things I would prefer to s=
ee
> something like
>
> /*
>   * logical_increment - the the size to increment based on the stripe si=
ze.
>   * orig_logical - the actual logical bytenr based on the stripe we're s=
crubbing.
>   * <etc>
>   */
> static int scrub_simple_stripe()
>
> I'm not 100% married to this, it's purely a aesthetic opinion.  If I'm t=
he
> minority then that's ok, but the above doesn't look great to me.  Thanks=
,
>
> Josef
