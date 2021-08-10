Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C983E5305
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 07:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhHJFt4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 01:49:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:40217 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234808AbhHJFtz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 01:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628574572;
        bh=gVeyFu0pfs1QcIklowlgK0bQ6nu9emFoVR5zOB9+od4=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=fev3ln+Qvo0J9de7mEy1hrSa2sjF+YRjAKgZtXqgXlTxHqXE9PC4WGTMs8qCf/Jms
         jRTnovbYPWyytZqFKmy6gH1MLRxoXEITvvbHGzr/cYp8QVjMX9L9xziHCTSqrNNABb
         MQAS67c5au7RvVenDRQWfPLKjppLEbL9abCNkxpA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbivM-1mpQc134yE-00dDx2 for
 <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 07:49:32 +0200
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Mixed inline and regular extents caused by btrfs/062
Message-ID: <db939df7-412d-aaef-c044-62fd2d8b2e7b@gmx.com>
Date:   Tue, 10 Aug 2021 13:49:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lJ/D4Ob0QNLQ9dawqroeXaEFMSoJZ7i/fRyrEGTwdC9fnYB7aY2
 +sPE0M7nC6hOCZIy2vYrEkoYkjE30K0/aWZqBUIR+K9C37zOsUdPuijUGsYGkjgkHRlWZp7
 f1URnWyHvaY4MIFabHLHVmLTRNmWW4m+/fUtn/SvbYvaWsbs3DxcbhA7gNcB/+tY0zSjsqo
 PoQm9itqlDjTDDgvOaX0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FrHJksXPuAU=:WfG1kfYPqjzulNPVrlezAL
 cCinPNNsayVGUxkprfVDz1EGsk72E8EVwv4yhevULRuWBb56YFNB/lclAW7l9ZtwrpCeKHFGx
 LJyp86bFdUAiBp2279L3yw1thHpGqiQkBb9c5tjhTWQHyJ26FJG+EpgtVnhCMjF1NuZg/IB/j
 FjixL5Sk+V+cMDC5WHGVOZQ44joDAUAo8BQdwk+xbaW91Y3XKfT1QNwybETWWfFeKdYLITvcU
 CiM2nmM0kVEAofhIr2iBkWlSFmeK5+McT6wlX0deta/m4oagM1BeDacKhU3aNeFoFEV0O9dbn
 9q/3UYfS7TLz3P9Pa3fA/LMyNWXfAzWFp6K2obsLVM4Nub7Wb85nTl3MuRUF+Cit9nYIBWt5T
 bJe9gFBL3d4GWVyIk8kdIy7DSJoVC42L8aYw+Zedsok5jHgdqL/ATJnfCaV0V536Ij8L68Z5h
 88adgzm1pYWFA0Oy4z5rwm0aZYhh75TIrKe8eZqE2XkL+JgDu3ij57wXxGANhQ0zRDacsjrXR
 qkhV5dT6mKaZIayaxOYIUbAM72NVgz19twSwEk9OSRap1ugGO5xSb8KMboWYPOYNVgjZ/4JUK
 rQytvyO0m5vRwtZMqmvj05HwQ4n6lTD4AZP8TVEwX/byxdVBn2LaH4ROMPIIdhTDFMG1hkSG2
 QGiVOsPTKyxxP5eKLmttDsuEmgIeUTXTlPsL5/MhSzcwD0tgK16iMwI19AqiIzK8wG5F9Sb/z
 uSncb4pmBBkMFhAkBFK4DMG++3AsJyyUsX/PpM0H3CNCKm2mVhlDl9vTk1WyNekIehZPls5jo
 8z6VWElqP5WBQAYmrvfjkIsr0EaCkzWGmgqD1ZA7ju1oMUMbgagJ6sSnJvWHDkgiSmPg8vNJy
 HDqItB8+TjGaAxLEom2kq3YAIFlnCSwQS9V9nhhHihfDcyGnKzN1h8pBiiGlr6qaXgLpPiGDO
 gY5vtxyIvcdRUgj5RsEObBf37jK3Et+s5874+VRS5f4TCrKDpI6Mmk22nnXlJF7e16GGt7vfW
 r4SE5yaU8Gol+FiIo36lYZ6fyVgI5cQRe6vyPDp1QN8JzPUFZI463oC4xrJaR+fWq3z0npjpL
 Fr95ePT7+lesp3OEL7hD9Edi32eBfsA7uSf2uFZHo7WCHUrPt/Wwf8qJw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Although I understand current kernel can handle mixed inline extent with
regular extent without problem, but the idea of mixing them is still
making me quite unease.

Thus I still go testing with modify btrfs-progs to detect such problem,
and find out btrfs/062 can cause such mixed extents.

Since it's not really causing any on-disk data corruption, but just an
inconsistent behavior, I'm wondering do we really need to fix it.
(This is also the only reason why subpage has disabled inline extent
creation completely, just to prevent such problem).

Any idea on whether we should "fix" the behavior?

Thanks,
Qu
