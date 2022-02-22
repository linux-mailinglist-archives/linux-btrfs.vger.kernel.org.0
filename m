Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD7F4BEEBB
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 02:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbiBVAFi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 19:05:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiBVAFh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 19:05:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF3F22BF9
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 16:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645488308;
        bh=w4ZF9fnzFP5Qmky6KbVs5YxRasFfZvyZs35y/hrZDr8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=I372/rGIm3D5Cugkpt6QgTdvtiCxe+wknvdCW7R4Jv4VUO4QlaLQZ0b7MVaDiJH77
         nTJiXvcH+p26x3EQ02tEHeD7cMlXQpI3AIY5/8sh+VTou9qJ9v2twJo2crJNSrb31n
         8tWDpphoIbr2JXiy5uRfLyHPShBkFRFK+GwcgQ3M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKsj7-1nfL8I3n2b-00LGD6; Tue, 22
 Feb 2022 01:05:08 +0100
Message-ID: <73686030-b0ac-66d3-1a24-8b801b666a69@gmx.com>
Date:   Tue, 22 Feb 2022 08:05:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/2] btrfs: defrag: bring back the old file extent
 search behavior
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1644561774.git.wqu@suse.com>
 <0dd2be27e93e7db12a3b83bdce48448a1f2f692f.1644561774.git.wqu@suse.com>
 <20220214161506.GD12643@twin.jikos.cz>
 <c372f57e-2ffc-6d6d-b656-5331464b53f0@suse.com>
 <20220221172223.GK12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220221172223.GK12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vUj8cbcteAgYl+TkwcVb6efXZIMceDbE8tYlp2FBSSK5vvNGFk/
 EX02frkvHDrwunwuS9lyRn4hPDoLkiRBw0RiXlvdU38k40Sm3EfyLvfyugPYRSn95PB5ss4
 Q0YeRsDTHK4d2bInb5FVdQj2GA09idRC42SS1RlarpgylhYnPP/oiGAPS0Jny8uEazi3RNR
 LDucDcGz7ijmbnKTgt8fA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Vk3cHT8lyY=:uNS0fJcJ7hIOE4T+wZgraJ
 7pKssdQrAQoQ60wSOf0UdoYhaCX4KqLA3QGyzYe1DrSEgEmx79eAyH6SLSk4ZvH1UKeew8KC4
 IeM4/jFq6kTjTr0r4muKlj9BIYyZcs8JIcH4jh7BEt78dGE/OX8gH5uSah5EEOldkIneT3oQq
 b+c3xOegZvGh8c0+lT/FgfEl0rOI8U6zVTB7f++O1n7m4NSY75K2ntxcceBee7VmiS5D5CWN3
 HRZLzQKs/yLi+lQtVRhkBhDMTrOCmCfBTR9d4H+/pA/BCc2/ckJloDIlHCag3MNt4BArzclSM
 emwllxEcnSJQ6R+wQxzoy0o28CljauHYFDfmbqO0kEP/6zGoaSP4qKUvUTMLJkO+Z0MKLRVym
 e6l6Z94znu1EXkSD3DjATVeN9hbxK8szeLELzQogQyMA8HuyaMfOjtwqC436gVwK6k7uLleb2
 2tGLlYsWHKuqHPJuOSWWtG5p9KwC4pk25YxVV/PPuKfg39gfcjGbibi+wfxlTrzp1PG1UYb1q
 MCzaSy+BQG/MpIgm53BdS5JflaUyvYSyoOTrY+e97vZkGwdWAqwQt0/tXFl/lsnIh603Lxm9e
 OSV7QBLe+chzR1BwV6uae8I/uJYiUkzMDHk1ooyh5V4VMOn5417309bXYaCT2f/082bvEvayf
 YdV6zEYUNv00VbXCis0YWZBa0LpKj50Q0WLzrgaryhY+cTvKVfun3axdWMKx7SsT8r8yQeBW8
 2tJN9gzsW5nnCYnOhwftMlNSdxUGFi4gD2P3AkhQaJvBpdxqzd2dvAVaxBzmT2kMMm2pfWkHA
 rwQptWw2TVQuShPY133wz4QSTunaTmW2FOBLGNdwFCf3d2mrtpZ99emykKTTlovRVF3LcHI/E
 Jf7DxK9mxQhhWiQ9WkhWUeKhBmUP53pR6w/PGfLnAQG0l7oCsLYimyL+j0Qgj8ROoy7sW2rVo
 tV6gzPocj+g1GUS6VTafCJXZrZXDsei6NsDZOzai2vClbbVM9X+T7i8TV6pNeSuWXgsIrW3Vy
 MHP16FaIiiv9Y/DxEzHcF119c/f6+2BZDWCU/v8wvgUV12GwxsC9Y2PY2mzG7iWq812dwe08k
 czm+FsDqo1CWBA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/22 01:22, David Sterba wrote:
> On Tue, Feb 15, 2022 at 08:02:35AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/2/15 00:15, David Sterba wrote:
>>> On Fri, Feb 11, 2022 at 02:46:12PM +0800, Qu Wenruo wrote:
>>>> @@ -1216,7 +1367,8 @@ static int defrag_collect_targets(struct btrfs_=
inode *inode,
>>>>    		u64 range_len;
>>>>
>>>>    		last_is_target =3D false;
>>>> -		em =3D defrag_lookup_extent(&inode->vfs_inode, cur, locked);
>>>> +		em =3D defrag_lookup_extent(&inode->vfs_inode, cur,
>>>> +					  ctrl->newer_than, locked);
>>>
>>> This uses the ctrl structure, if this is also supposed to go to 5.16
>>> please provide a version that applies, thanks.
>>>
>>
>> The conflicts are already smaller enough for this patchset and later
>> autodefrag work.
>>
>> I can easily do a manual backport for v5.16.
>
> So the change is to use newer_than instead of ctrl->newer_then, right?
> I'll use that so it does not depend on the ctrl patches.

Yes. But please keep in mind that there are some special hacks used in
the original btrfs_ioctl_defrag_range_args uses its @start as
btrfs_defrag_ctrl::last_scanned.

Which sometimes can be confusing for autodefrag fixes.

Thanks,
Qu
