Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6242A9E30
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 20:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgKFTlB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 6 Nov 2020 14:41:01 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:38521 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgKFTlA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 14:41:00 -0500
Received: from [192.168.177.174] ([91.63.191.240]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1N0o7f-1kMUZS0zSP-00wmRL for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020
 20:40:59 +0100
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: raid 5/6 - is this implemented?
Date:   Fri, 06 Nov 2020 19:41:11 +0000
Message-Id: <emd2373acd-6dfe-4317-bdf7-402cb909bc3f@desktop-g0r648m>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/8.0.3385.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:ezJCodXaMUSdIyM9zeqR91ISrANsz6X3jEWif9Oi3QFQnqdQfs0
 o2HUZyeeIC2W8d4xAPpyF0Jy7/mzPcKYXENm9+s9raPUrv7v3mDM23ZJOVehZx5RZ0klNGu
 8bNGoeiCKy5RaJxzC/HAbeo3WUwVLWw57FbOmaHHubazUAOegdfFTAYd2kVXzJ5E/Y8TjqW
 GJUXJ2xYCJhScqG2h0m8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YCqurMWkgv8=:q798LL71MsQ+S5CHESXFjR
 6hMgrTWsj1EiqOFbJg8p9VybjEKHez1a1R96o+eSRXErXlLQubsobdaReo/x2nCONING9RdBV
 rMBZgWzkox6PKv8OFGDhtgwbeDwsyNEd1j4tuPdiyzNXhxf+nP4AcRfEF9cZaRlCDFmrpA4rp
 gk4WraxT2sx8uYtu3iMSrCQR4ics7memcv2YD4etUyAej+5Cbc3K6RpC+oOlp/ppRi6HXqQ0T
 S0/AoVm3pCkKINBPeoL5YGZ6TADEU28EKHw2hJ1AA6ruGCmIeZPfHvCbWwe9uC6aPRbSG3pQe
 nOYONBfRs9AIVxmdBbRkx8VfqNbNkeyEjlCV8pEsDm8VABopSdO0oTtI9I2nA/cOGAeCrPpeq
 th7mLJmbZFWv74W8u+ddNjklm874KjfczSMvVQFfnjfUnsqgGF7etssmU9PXQ4CklKU4XRNck
 kH9GGEsI0A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I stumbled upon this:
https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg91938.html

<<This is why scrub after a crash or powerloss with raid56 is important,
while the array is still whole (not degraded). The two problems with
that are:

a) the scrub isn't initiated automatically, nor is it obvious to the
user it's necessary
b) the scrub can take a long time, Btrfs has no partial scrubbing.

Wheras mdadm arrays offer a write intent bitmap to know what blocks to
partially scrub, and to trigger it automatically following a crash or
powerloss.

It seems Btrfs already has enough on-disk metadata to infer a
functional equivalent to the write intent bitmap, via transid. Just
scrub the last ~50 generations the next time it's mounted. Either do
this every time a Btrfs raid56 is mounted. Or create some flag that
allows Btrfs to know if the filesystem was not cleanly shutdown. >>

Has this been implemented in the meantime? If not: Are there any plans 
to?

Regards,
Hendrik

