Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9446BD5B
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 15:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbhLGOTI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 09:19:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:44289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233173AbhLGOTH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Dec 2021 09:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638886532;
        bh=OI0Qa85eh/SsV0rDDdm5iq+MSLSyjY2SqcwEN669PDU=;
        h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
        b=HfEADSpEn8o+Ru7aT+KDLDRgBUcMtJeIpCuXByp4xC3csnVdLY18FoG3u4SlbsaIN
         OxAz/Ato/6tQxwdg1nqLmCNQWdg4sg2+PoiAMTSVYGggy6DDEQfKxqN27qP2T5tf7c
         0rfEca0hVBJHdUORDTGWRphcxHVBm4TAQ3R/UfoA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mn2aN-1mAmO41V95-00kBnQ; Tue, 07
 Dec 2021 15:15:32 +0100
Message-ID: <d6054895-8fc8-953d-db3b-598dc5086355@gmx.com>
Date:   Tue, 7 Dec 2021 22:15:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Question for information about the Extend Tree structure
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Maximilian Eichhorn <maximilian.eichhorn@fau.de>,
        linux-btrfs@vger.kernel.org
References: <c2ecfb9c-5044-a370-2362-8f67b44ce53c@hogwarts.middle.earth>
 <d2b335a8-f615-6506-8b17-f4a1f61ee7a1@gmx.com>
In-Reply-To: <d2b335a8-f615-6506-8b17-f4a1f61ee7a1@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/1KZBRwNh386roT8jHjSEST5lHYiACNS7q2h47d9u5svH2BmkCi
 Yz3ERyY8BTqGcPJ6Ug1SvUoJ1AmQBON25Nn4M7wbdDHV6QJv2HwJXvv+oQdTo5jzLvoR+Au
 fdzYYL1a9SM093gwgbYlpcb6Kpm2Zw2J1yiN7aBrHhy6nUXXnvayNonaTCnSy57MfrvLq09
 V8mopxvKug93aSX84gdZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sGu/mEUJLKQ=:/4XIR7tPaRbceong4g+3gZ
 pQP81OP/A7C7iDwX6XpSK1DDPzg8awbK8PUD5bPpUYlD+n3dGIgk1ECwMAqFsfkq2YqfNYPjy
 +oJGdmSPq/RodwVnV+zqHMkkX/RK6OXWzDejyczvqhReo7IzNjJL3RiSeoi225CoSJebd3Sc4
 6ZyxR5Ogi/uTuROqy1bKvdITgNvcCONBaSZ9RBP8wJHsoLKIJ6QllGpDy73QuSN3EXo2xIDyX
 ZY9KxfZtUGb0/eFG9C4H0dVICJUviGLKz8OBMbqY3B5UxFEj0jq6VnIEVVF9/mOdJUKwtLNuF
 vuImJ8hRTqS6DCeSw51vOhS6GIfSnwRTfyyEp0W8jWaKnBFDZLoT423+BgrwNF3tHW+NSzAgt
 hFwstc8PhTGMFQTMuH5s9Qo5u7Ed9s0Fzp34UrMmgEe6OLDX+ctiqKtGaUFykFRL0G2683Qu2
 pkZ4wFCJvkw8tGD/uPVO3BjZis9v6VzgkEtT70hFWjPsqA2+WWadcRJ9r9p+0M6ICkwNXdWGx
 xuLzRIAZVsMt6LLW7KOsN+QEWiLQ7k07pH5Zq4AUhKq61QHon9W0hJBXtsWdKWFYBHbO9Wl/n
 POJ8cFE2WqMODSnh8dihEF9KKoNt/ateJ5C1X7+KtOCMD/4k2WqX5eA1rBhhiFgvHrnI5xrq/
 6PwRk+S8l8PZMp+DrhubyifpbcOpykIuXCEIPgK8RTNw08J2Bj/q5beKDcUF1weCbtxVZKQWl
 BhNTq/GdP3dLjXdmFXHhVfdlNTxSvpXwQMiDWnO0pVPmcxvdg5nrrEmXPJJHTWxX2nNRUB1MJ
 88xdRqA9lE4+Il4qz50e3jWQJX9LoPHWgKe51w/x7xLUXYCo/B6Vs+7+2z2DvlxH7607X9EUE
 FM6NuZXDFKcgzsXvPgvlAg3IqRtnz2OveK7fj7jR+N1KvfstTBkT1MwA/I/UuC9Ttd7GlymLk
 ZX2W51j3EoUyQUCDH+s3BwyNYsjySktmRWQecsliwhdeL4vvY6AaI8lLhLvcyAtFFvH5UioWO
 RAXt8TG9gRW/D+YhLlG7CJNT+sJJC6SoU7cp7jMtvxfVdi2ITay5WG0FXt68WCcPAGNV7DesK
 Cg/vkaCoWclyrQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/7 22:09, Qu Wenruo wrote:
>
>
> On 2021/12/7 21:53, Maximilian Eichhorn wrote:
>> Dear Sir or Madam,
>>
>> as part of a research project, I am working on the file system Btrfs an=
d
>> its structures.
>> More specifically, I am learning about the extend tree and marking
>> individual areas as allocated.
>>
>> In the course of this I also became aware of the wiki [1] and examined
>> the information to be found there.
>
> I guess you mean this?
>
> https://btrfs.wiki.kernel.org/index.php/On-disk_Format
>
>> However, not all aspects of the
>> Extend Tree are clear to me yet. Therefore I turn to you with the
>> question and request for further information.
>>
>> In other file systems it is very easy to identify a certain block/secto=
r
>> as allocated or to manually mark it as allocated because of the existin=
g
>> structures. Unfortunately, I have not been able to do this with Btrfs s=
o
>> far.
>
> First thing first, other fses are mostly using bitmap to indicate which
> blocks are allocated, that's why they are easy.
>
> But that lacks a feature btrfs needs, to do backref lookup.
>
> That's to say, when we know a block is allocated, we also want to know
> which tree or inode owns it.
>
> That's why btrfs extent tree is that complex.

Forgot to mention, for your traditional allocation bitmap, v2 space
cache (space cache tree) is your best equivalent, it only shows the free
space, without the hassle of full extent backrefs.

Although unlike regular bitmap one, it goes a mix of bitmap and extent.

But still way simpler than extent tree.

Another thing is, extent tree and v2 cache are all at btrfs logical
address space.

If you're going to check the free (unallocated) space for each device,
you need to go device tree, which is much simpler than extent tree.

Thanks,
Qu
>
>
> But if your idea is just to get which blocks are in use, it's much easie=
r.
>
> (<logical> EXTENT_ITEM <size>) is for all DATA and some old metadata
> backref. That indicates one range of bytes allocated.
>
> All data extent should have one such key. For non-skinny metadata fs
> (without skinny-metadata flag), all metadata should also have one such k=
ey.
>
> (<logical> METADATA_ITEM <level>) is for METADATA backref.
> With skinny metadata, all metadata should have either METADATA_ITEM or
> EXTENT_ITEM. (For newer fs, there should be no EXTENT_ITEM for metadata,
> the co-exist behavior is just for backward compatibility)
>
> For METADATA_ITEM key, although we don't have the size in the key, since
> btrfs uses fixed metadata size for the whole fs, the size is fixed to
> nodesize from btrfs_superblock.
>
>
> So just focusing on EXTENT_ITEM and METADATA_ITEM, you can get the
> allocation info from extent tree.
>
>
> Talking about the marking part, it's pretty hard, as although you can
> mark one range allocated, you also need to insert the proper backref for
> it. But since you're not really allocating the space, the backref will
> not be valid and will trigger fsck error.
>
> For a proper EXTENT_ITEM/METADATA insert, I guess you have to jump into
> the rabbit hole of btrfs code, btrfs-progs will be a good start point.
>
> Thanks,
> Qu
>>
>> Thanks in advance for your help and efforts!
>>
>> Kind regards,
>> Maximilian Eichhorn
>>
