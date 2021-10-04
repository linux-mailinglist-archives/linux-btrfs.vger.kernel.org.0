Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987C2421A53
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 00:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbhJDW4Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 18:56:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:60625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233501AbhJDW4X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Oct 2021 18:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633388071;
        bh=65vN1O7VLKq85EUxWJhNkzbXhJ6ZaKR5Tn+eIxMz6/g=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=PsBrm+alhnIB1GNzH+oDG3Elo8oNzVmTjbVA8uD9VZkXTfga2046WJocpn176Wb5U
         pwa1+YDEzbp4pX7bm4VB9KuE0n4p4ikELxCsT22GbfvAPS5ok6nkaEZneRQ3aT20RJ
         AmYKnc5RqgDEgzBjqPP0Yxi2ceBZuOxGaOJ3pvqA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWzfv-1mHz8Z2iBl-00XJEv; Tue, 05
 Oct 2021 00:54:31 +0200
Message-ID: <d2e7dd3d-5cbf-287f-893c-bed3e6219d0a@gmx.com>
Date:   Tue, 5 Oct 2021 06:54:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     Matthew Warren <matthewwarren101010@gmail.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <CA+H1V9wsz2y21qxaYAkNa2PuBUCnM4yFVpoSC5rGav-1LHdwHA@mail.gmail.com>
 <20211004095146.GU9286@twin.jikos.cz>
 <CA+H1V9yopc2okgT=5XeCwvHF8oXPVhnojaf_rZOeuiThZEfqWQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Changing the checksum algorithm on an existing BTRFS filesystem
In-Reply-To: <CA+H1V9yopc2okgT=5XeCwvHF8oXPVhnojaf_rZOeuiThZEfqWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EGCTze4wFjoIch9/Lsgzlt8B3I5rWa4cIFQQXo4ytuC2p/3rq/+
 H5+kHlQM456Mvwu1gG8ORYM9OVmsLnIworud2fJVGcYdlesjMMzaz4e8S4bYgzh/cl4s0xM
 GteDsqW+BcTG9SGb0V009Ck4pKkZcUxgaoziWMK/XUP/aTV4YhHFQG2POwZjWxjp7d2LO/L
 fyXZNyIy9PbWUOHXyNx8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rSeDdz0B8eU=:KaLn+Vmih1dNaN0t8+rwO1
 Ru7huzrzwuQDch1XZ7Hfkbh8AX2MI79s8bN8ZSzyRYXHV4ofF0qccO8J1x2ccoCMG29fr2DHp
 1aSdWjAilFfxeGXGs7odH7zcRjXYj2wdjZ1lUFe2cTNKIwe8TMdp95HKlIh5BUWZf7W9X2zaJ
 HXF2bAS0DOMn5McCdrD5KnLkfBtwwVPWRhS4IR1ChvEuXQ6n//IP0DOd/ZJtvtgBIGZrbLbtr
 E37Hpct7LB4Y4cpDSYwdBGYCxh0kIeD9L2zv+n+e1SJULhpglmKu1nU8GSfcLl3rzgCRPwybN
 kK6yLuOswsTraxqdefUnh3UIyfepv1FhU08h2RL2U4TUi8gwvxDmdCffy4E92ZDFJaqDZIW/N
 dqN+ptH7EFEog05rkDf/IyMSwyYkXI8cjNvmub44+f0uGERF0UJS10q/1ehToCluBHhP3u3Bz
 1HWe3aQnqWjwgt9kmYcM3/0S+ufG2KunIoKsjp3EdnAG9Ek2Z4w8zb4h5b0jPu/FjYsyXppxw
 JGk/udC8UUal4POH95peCUHPIqlR14ZbK4dVp9Dle9tNTvlpomBs1cInkW96ocwLuHVuifha9
 wogwnsH4tfw2+PwOdd0CTDPeBrGc2TdUIVLSQQIhYS0U2YY7VUx49bbJs4s1zV++RdPa3wh/j
 +fOgo9NQmE/tor7Jr18s9dxnRsFxM6aXHRs01rgaivXFAG6EFPKdWZ4mrjwDn3MAIbFTbIewU
 wT1rTV2l24GE4r9TkMuGhNCX8s4Me3nviC1cp1C7JLUh2yOKYgxrNuylfSZJY7W5qz4Bibszf
 NutcbgK15eiiT+MEZCai9x9bHLms5zPeliZ26B5Mx7zha6uBdwmtHJGZ87fSc8Jiu25B6MuDB
 +jhHZHJDOVER7w4VC3iuJHHgdZs58Vx0EM311Jc28tbMem28Sv7osY8bN7b0XtwAS2j9ESjpZ
 z6EL++jhQ8RprP1sthEhLQw2eTvM69zJhyyhjBteZYKQ4h+nonI+bE7+HbYykHvMEMpC3d4Z/
 +AAmltZMhFGz0VVFc25YBU7WHrQCeEebwvs7VrMz8ZlSb2OI9rIXVp2EB6IC05sw5AfgbIinC
 noWx9K+XY7N4qI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/5 00:01, Matthew Warren wrote:
> I don't know how btrfs is layed out internally, but is checksum tree
> separate from file (meta)data or is it part of the (meta)data? If it's
> separate it should be possible to build a second csum tree and then
> replace the old one once it's done, right?

There are several problems, even for off-line covert.

1) Metadata checksum
    Unlike data checksum, metadata checksum is inlined into the metadata
    header.
    Thus there is no way to make the csum co-exist for metadata, and we
    need to re-write (CoW) all metadata of the fs to convert them to the
    new algo.

2) Superblock flags/csum_type
    Currently we have only one csum_type, which is shared by both data
    and metadata.

    We need extra csum_type to indicate the destination csum algo.
    We will also need to sync this bit to kernel, no matter if the kernel
    really uses that.

Thanks,
Qu

>
> Matthew Warren
>
> On Mon, Oct 4, 2021 at 4:52 AM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Mon, Oct 04, 2021 at 12:26:16AM -0500, Matthew Warren wrote:
>>> Is there currently any way to change the checksum used by btrfs
>>> without recreating the filesystem and copying data to the new fs?
>>
>> I have a WIP patch but it's buggy. It works on small filesystems but
>> when I tried it on TB-sized images it blew up somewhere. Also the WIP i=
s
>> not too smart, it deletes the whole checksum tree and rebuilds if from
>> the on-disk data, so it lacks the verification against the existing
>> csums. I intend to debug it some day but it's a nice to have feature,
>> I'm aware that people have been asking for it but at this point it woul=
d
>> be to dangerous to provide even the prototype.
