Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920775B52B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 04:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiILCzP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Sep 2022 22:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiILCzN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Sep 2022 22:55:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226DE12D37
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Sep 2022 19:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662951309;
        bh=Fdv809z2Ea/srFXBy8a7hcON9/hYRWj9UvXsuY5pi50=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=KIcMNBE6B+alWwdc/mFTADdxWFUX2AmhIBnObzXF4RKdz2agIKbHzE7W3fT8QLlbj
         SX+NYloPXSjums4Wzb6cv2LS24Oac+QV8yRnp1cZNEFstLHdpAgOM/EM2CX7uF607V
         pZvJdW4SY42wCgCza7ps25s8qrNNAC/4RtrXSniA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mv2xO-1pOIiC1QDw-00qw4W; Mon, 12
 Sep 2022 04:55:09 +0200
Message-ID: <e37fc471-7020-931d-4ba3-9e4834875332@gmx.com>
Date:   Mon, 12 Sep 2022 10:55:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: core dump in btrfs receive (while handling a clone command?)
Content-Language: en-US
To:     Antonio Muci <a.mux@inwind.it>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <f3eee248-fd90-4048-8ae0-536997b4c273@inwind.it>
 <c4ebb761-f60b-de1c-3e21-d4a1718f40e2@suse.com>
 <75ad4f12-dfce-5e9f-4361-5c8c28ea5c1d@inwind.it>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <75ad4f12-dfce-5e9f-4361-5c8c28ea5c1d@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VgZLPAcbSCuu5hv3QYxXoo5EGoe3I1nJv4MEHXjQhuhHE8F/WEI
 tBG7KjqBia1kdNOtMiLIJp7ccRX3+VFY5OjBSfmOb/vymcF2VMk4Twwmyq7D559pW/6akEL
 5RiV9Iu8RMiDOr33+jRSUXe/HLLt8X0cqPLC2Sx6gJm/gBb5yZ5vB0yboiwBd601WZxxVts
 +r3fcWTMBw8jQkUXmfVWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MPej9ypL3U0=:bCFZ9nDgnGPbJ5Dx90GAXV
 B4XT7ElLexCJxhD6yXNeSYp/qFs+rc1+hWWLZ7jFg2/XHfmSYUrMQgR8QH9q3w1AngvbFbvDJ
 3maSXaC+xxeoUXO1oZXlHCFsIQwWQdQKBTzR9z2VATOGzWMiH6rhTfH0u4pwyPEInntS/8rnt
 GcPnMZ2jwHz2I1ELA3U3ZhyYK7raqvZR7/XNKsIFlb+bhIhKC82ji2MRk2RSOgKY46xS9l0G7
 8N41lHyijyfVCR5FJ3hRfGnDxn2i6Z+dACxEXf+PdUSKPt6XQ9/wuWDoisStwQvyq2OgAKuvf
 SxKXdUhgExHzw3Cf1hSk4TGuzO/EFDe/YCMnjAHdSZATv56bFZP4cQQ6DtQXKqT+g5ojXjmnk
 Dxh/VVXBgZTxFwznR/Y6qdswzovibTjhgBLHwih+7/7Utk5Z70bI4y5q+MxjVrr/8DkcTvMGH
 gH6D4/wa1A3gx/2mpswz/xPkoD49WXa/tNczF7WXGcq9cQi0q/D5gZGNgCEBwAVGFs3Sj1WF3
 ZFYY5gJVy56G62b8/sItseZaqNHdYCr/XvX8+qKMgx/Pdp/hhliZf8iMTgWBA93//PAStl6ev
 qNw27ri9BTlUW+GMMNU8ShVcM2OIFmQC/d7dC93KwA0VbtQNcZcjNbGhBMtCjy4QyTmvmMfrN
 SlKSklwBSUIv0LQ8AJnQ5sKUe5tzdMvFVdXIsW0zozs5Ptb+CP1t3SPwo0z+nkYsveNotsBLa
 KF2nFRyQZp1WCasIp+juFIVs3wyVI39hs/7W5qhjZ2O+3Y0O+KIYLYmG7CTdgxN9vrxChUTFY
 fUcLubeFHR/rOBY3+Y245b5h3094eecI/MoBk3RWz8hlbYeQINMv8niFn9lnU/s+ZQB9FP54i
 2aBU7hQZQNfjus3C6ZdWR52UiMzwLyexID062PsbroRDb7SPiOBy0oG5nRV8v2M5YHmvoTrTf
 Ma1ZmhrZL27qpjNOX9TFxJro9lCIszmSDshI0F7b0U4x4CUAoTFpY3xfzgCAgr9jQQ38DOjV2
 c7Wvh1gCEfCk3bAxhbp40Ed1mh/9FkOVuyeUmGyKADe+YA5iEVBgpN+uBCf0lBk9IFuRoaZjt
 iP1KlNvyjizAZRZ7nCVa/HgShw0GMnRz85dTnmEmLtRn+yKNTsLdFaYWH+YOtKnaa5TT+sG+o
 PcCK3cXCQKLJ9Syl4lUk86Nbxb
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/12 10:45, Antonio Muci wrote:
> On 12/09/22 03:52, Qu Wenruo wrote:
>>
>>
>> On 2022/9/12 09:43, Antonio Muci wrote:
>>>
>>> # gdb btrfs
>>> core.btrfs.0.2799d9eb6dbd423aa57676cad3e64ee7.3152.1662942112000000
>>> GNU gdb (GDB) Fedora 12.1-1.fc36
>>> [...]
>>> Core was generated by `btrfs --verbose receive --max-errors 0 /main'.
>>> Program terminated with signal SIGSEGV, Segmentation fault.
>>> #0=C2=A0 process_clone (path=3D0x560c9bd24a80 "db.sqlite3",
>>> offset=3D1045131264, len=3D10760192, clone_uuid=3D<optimized out>,
>>> clone_ctransid=3D440,
>>> =C2=A0=C2=A0=C2=A0=C2=A0 clone_path=3D0x560c9bd24b40 "db.sqlite3", clo=
ne_offset=3D1045131264,
>>> user=3D0x7ffdd23aa3f0) at cmds/receive.c:793
>>> 793=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(si->path);
>>> (gdb) bt
>>> #0=C2=A0 process_clone (path=3D0x560c9bd24a80 "db.sqlite3",
>>> offset=3D1045131264, len=3D10760192, clone_uuid=3D<optimized out>,
>>> clone_ctransid=3D440,
>>> =C2=A0=C2=A0=C2=A0=C2=A0 clone_path=3D0x560c9bd24b40 "db.sqlite3", clo=
ne_offset=3D1045131264,
>>> user=3D0x7ffdd23aa3f0) at cmds/receive.c:793
>>
>> This looks like a bug recently fixed by this patch:
>>
>> https://patchwork.kernel.org/project/linux-btrfs/patch/20220902161327.4=
5283-1-wangyugui@e16-tech.com/
>>
>> Mind to test the latest devel branch which should already have it merge=
d?
>>
>> Thanks,
>> Qu
>>
>
> Thanks, I tried the latest devel branch (as of today,
> (https://github.com/kdave/btrfs-progs/tree/efd6cfb74bb6a7218c12eaa27e455=
be453082c81)
> and I was able to get my data back!
>
> The crashes now became error messages from the receiving process, like
> this:
>
>  =C2=A0=C2=A0 write db.sqlite3 - offset=3D1041842176 length=3D4096
>  =C2=A0=C2=A0 ERROR: clone: did not find source subvol
>  =C2=A0=C2=A0 write db.sqlite3 - offset=3D1055891456 length=3D4096
>  =C2=A0=C2=A0 ERROR: clone: did not find source subvol

That's a case where the reflink source subvolume is not found.

IIRC it can be that, if you have received a subvolume, then change it to
RW (not really need to modify, just change it from RO to RW), then the
source subvolume is no longer considered the same (UUID changed), thus
reflinking from that subvolume can no longer be done correct.

>
> I have verified that the two files have the same sha256sum, so no data
> was lost.
>
> However that error message is a bit unsettiling: the subvolume
> reconstruction is only progressing because receive is running with
> --max-errors 0, i.e. ignoring errors and continuing.
>
> Is that error message just a too alarmist wording, or might it be
> something more serious lingering around?

No need to worry at all, mostly a RO->RW subvolume change preventing
reflinking from that subvolume.

Thanks,
Qu

>
> Thanks again everyone for the prompt response: you saved my data in no
> time!
>
> Antonio
>
