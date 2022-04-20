Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A6C507EBC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 04:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358902AbiDTCUH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 22:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiDTCUG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 22:20:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E86D2FFD8
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 19:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650421033;
        bh=5m2S33KwigMx1Gfsuxhi6k1HEsi4NAvJXZEiVO4dfMk=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=PCNKfvAyKd+g1gQ6ONU1t/z0FIrec2wm7Bb6DtOUHmVlmwVJvD+SnEP2NvR5sjcRK
         igFbPNirQVbpFLS4oCcfe9hpKFSJIgNRJy8awBrN6BDv3QjEL7QRagUAbhqQyx1SC4
         ujZqZsskZLJuJsDR8kAN3zzW4pDku0vhIpjDLbno=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWzk3-1nRECP2OD3-00XLTO; Wed, 20
 Apr 2022 04:17:13 +0200
Message-ID: <a59b507b-f528-472b-29c9-da2e62deaad9@gmx.com>
Date:   Wed, 20 Apr 2022 10:17:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: RAID-[56] stabilisation
Content-Language: en-US
To:     Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <22677769.8507095.1650409322744.JavaMail.zimbra@karlsbakk.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <22677769.8507095.1650409322744.JavaMail.zimbra@karlsbakk.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s+hB6b9E5r6PoEirbSyGCuAnIt/c0OGaV+IJQM/2hG4OXaJIpbW
 xd4Zq2W2yIApV/EON+MABVMBFG+VTGsHgOU/ro949EgD16jiWWh+UC/L0ynVf0CBWNpwZBp
 3kKeXUvXqVY6c8kOqLlhJU0pgBbrrMKlln5S0LB3/Zy4fGS8Uqq4Ixs9iWkHazCBlHeDRWt
 btF0avBD//BpSLWgJteOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UvMF2pI/l/A=:24nf88AMkrfMRnrpWiYKJe
 /aTd0EMv9klE1o5y/5+iyDyNe8MUcKZ8GEiSTLmGqaZWBOCaJ07SCXtS/TQl0rgnqqUrMIL7s
 m2why+w568AAml8d4BelVisbzJzgb07XdZyBRU7NKUiRnsUz8tqQgGSf0CXi+gS5mwi0bcAKd
 E5FTpRIcpqP9BLS9SKg8bVT7tknQg9WLeDWaXBNUn7rGRLfVy5nmWCuBjqxNRO7RdAGczVUdZ
 8ZjNRPBjdo9zGYLyLCypOVGxJIYcrjuvI3zDfTedBCE2SG9xZJetuEeEob1Ugd/Ax6IQj8M0f
 ghzVSd4B+lfQx+BL5DaZeR/z9yv5lo4W5mdOGiXPxjBw+MVe4Z1W5aSTZBBF9g+K1nVZd6Q69
 2Z0HcaaKMycot7FDF5CxbwmO8EdlC+Fpxj1PPJQ8otJuYCj8P73Z3y1ZRzYmtzkNV56jGNDnl
 D1J5MZOsy1lTfgKNQzOQ7Y4/yhBHW34RR9Clh2UnOmXZ3Jd8Ncb008uN363p4ad62hkQiI79O
 Q7hVOSWgK6N1IoKGeL5vKWPmdgg2i5nOzv85hnGQUln7ZTSTfBo51HZhtQK32hArMZnvO7Kbv
 DwTfaRs44x2PVP9UGIWZaWg8AGMbWVK0qbRGkelXTR3lTIP7GGmhw6EwQVC2HOCD2+EW8e9u7
 mxjHCnrh2FH2aIlK7trP9yfPCL6M0q79iQtg0XfZKp3dFZrPoNw2DxNRJhtIXoxRXi1GVXDeP
 mPeE68BA4s8OBuQljS1MCj9c0daLi2Nghur4cksQ5jN3EcRN/o28Ml6VsNgaSTbJNINP/S492
 7YEsxkVwrOlVHdS3Zev515g5DHdHCD05+Y3+cv1yhxAvgIfEKPf1tQbsEOlwrZ7HjdUPXhHM1
 QVzzAEloKkD8yrYWS1KoP40wLc1WR0DLVkBuphTxbDylYIIfIrtpyBm+fQE6o9tgVH381NKHT
 2KFtMK+AQZlBgbeE07UUrx2iUU7as74FH1P4pcCdgpb2qTjeD2lBAnOJJ+7eft4B5iCcbX1ar
 MOsK/KVetp6CT5cM6NVPFM+RdPQBECofJVqbHz+AzrYg/nNIhbUBsetByzDpIN9gvfaA/ediy
 9lHGSEnRdfIxA8=
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/20 07:02, Roy Sigurd Karlsbakk wrote:
> Hi all
>
> It's been a wee bit more than a decade since I started to look into btrf=
s as a possible ZFS replacement. I just wonder when one can expect RAID-[5=
6] to stabilise as in usable for production, since this is, for my use, ra=
ther critial.

Currently the main problem for btrfs RAID56 is write-hole.

To solve it, either we need a big feature in extent allocator (to avoid
allocate extents in the partial written stripe), or go traditional
journal based RAID56 (needs a new on-disk format change, and new code).


If your use case can rule out power loss (by using UPS) and unexpected
shutdown (no way to prevent kernel panic though), OR you can afford a
full btrfs scrub before any write (can be very time consuming), you can
try btrfs RAID56.

There is some plan to implement a RAID56 journal, but there is no
concrete time table for that yet.


Or, you can run single device btrfs on md/dm-raid56.

Thanks,
Qu

>
> Vennlig hilsen / Best regards
>
> roy
> --
> Roy Sigurd Karlsbakk
> (+47) 98013356
> http://blogg.karlsbakk.net/
> GPG Public key: http://karlsbakk.net/roysigurdkarlsbakk.pubkey.txt
> --
> I all pedagogikk er det essensielt at pensum presenteres intelligibelt. =
Det er et element=C3=A6rt imperativ for alle pedagoger =C3=A5 unng=C3=A5 e=
ksessiv anvendelse av idiomer med xenotyp etymologi. I de fleste tilfeller=
 eksisterer adekvate og relevante synonymer p=C3=A5 norsk.
