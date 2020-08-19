Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847BC24A8B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 23:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgHSVrc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 17:47:32 -0400
Received: from sonic311-14.consmr.mail.bf2.yahoo.com ([74.6.131.124]:41642
        "EHLO sonic311-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbgHSVrc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 17:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597873651; bh=QDT11FSBX3UVcMqL/L7VsYO4wQOAHUBEusQIS5epyHo=; h=Date:From:Reply-To:Subject:References:From:Subject; b=WCJ7Kfk5bAktAHD70DL/qAEpsWJURSjoI/F409fQC8oNZ1GifdqcoLDB+D6DqlxIcPvM7RRod3tzAQiB6XIBtUabRnVK9vN/O17KpvVRtigR5JCkS8PEjvbf8rAxAXM4++fPoADyUfi4JFJGpyLxUkrBkx4AUiCEj9ET2yZhEH+25dn9p2xfEhxNbLnB/S36QwjxSp78klfqV9vlNWUw2t0MnZbggt+8XuoQscnTsyhN+G4qB+TqbE/C3/uRfd73W1mjJbC64hqxWcLwOE3xW3yRbvVRG+GmaMGSuuv5NQVRGXuh+bWHKI2MmFvAGFmYYSmSsxBEWEW/0W6T1ZtAXg==
X-YMail-OSG: 8OC1L78VM1kAevXpsqjKOWsvuFXMcTEaHEd3EXLRou4IylbENES8yIxLzN0KqK7
 745u_G9E_drsO8kjPEo1J2CBtpNJXtnlyfE4EvHSDg7sRWTON7WgvKwFtYHXoKkkw_mr.NguJ1Cl
 IHuJPsM0OZVx8qoerzJqQqxlWgDLbTfRykYqYCN9B2jO_fsmruoqnSvcWN9Q3dMSx3MaapAup.aY
 G7D20U0P044IQMBqUbFr7RW0RItqEy4LZoBqwWYC1qz_v1ydCPWFItjuwZEzzB_FqC1idLecoW1b
 d52rPRQ1hfkAYfMg1We5rrpLmGy5gdF_g5OAyx8LdJEm8b2jQJmyFrQS02gSGdo7vnJTaQM2fR3K
 tmY1q_gPt_Y6N_gvMxvVB4tYMG4stRhj5iqOccMZrLnR3LpKFmOc7uoEPt0BKtMxS8O4PU3PiyaR
 fqLS3C_fhpJAMMzAkLyktkIGYzBMNbNWO_aANdZbwjPemh2OZny2_1GNGCMexp2cmfDVWyqMMg2D
 fDl29YwJ5BK1EkFbEa6_6TqX.udLrOyji9z7kZA5lcIE0GMpqNec4DBnxwDVKD4WeYHYe5RDlYdf
 6vek9yl_HT4pAsKN6SZUkNV7G9Zqd0HDgLKZVdKi3NoOESXJDczcSvugaicWR1L63j9fSxMiaC_r
 to5DZ6NeCwPITd.8OE_D8p8jTGcbraWVaGC8_7qKNjZdyyDKXn1JueUEKqC.LX_gARZDohBm79ys
 aR8eUo2r_8sIKl7.OYxifQ73LwihOYTzTcqHx5EUGdQXiNVRVrdC4fQVLCa5KqNPPTUO0roW9a7w
 4OtlQimCZHHKIsT90yF4AujiBxvI1L4ao_KGsv7830UYyspDOgIXXgDiSvw9A.isG1d0F1oFGNSf
 EkOSIQ952VcBfU8on3qYcAe3m6i8D5nbs7BqRgIIgSHxLhaUj_xtpbyOQ1afBOeVphu235idX5yM
 2dqCYoYHIstIhEVv3Hfmk.qlhVJQHWzDNQJG3_5NseoNilRcbd.R7TVpi1SvQbYxwQmULYB3XjVy
 nkWndkluW7qLe3g8X3s1erNWwjbzkJIR0UG3LMLDMFLkGKQHTL8vNQhKmc6YoMffEHiSKCDDigpu
 6ZrtmnyX8XMlR4pJm.NK4HtatnXIhax7pbgsCr4AHymkhh1XNMEEQUYlV_w46EDrWbVsEJhRNT0H
 du_kF9YDkzq7yR4bQ12oMag5Jot6cjNGNiG5tVlRDSVJWW4gVZIxDSJ_UCIJe1itG0QNp0U.UznM
 EyfBXo86VBwGPHRrT9arvC7f7J2DEkE8i0GS8R1ttM6c1dn5hpwn4DWl0UIUhJdRo5xsjViVX4x7
 qHxOEXIAVHWga7s7WNZ68CXuUa5qDZfd9g9UzfG.nBzjOxdlBkYE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Wed, 19 Aug 2020 21:47:31 +0000
Date:   Wed, 19 Aug 2020 21:47:26 +0000 (UTC)
From:   "MRS.ALICE ARTHUR" <mrs.alicearthur232@gmail.com>
Reply-To: mrs.alicearthur12@gmail.com
Message-ID: <1987042962.3481959.1597873646361@mail.yahoo.com>
Subject: DEAR FRIEND
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1987042962.3481959.1597873646361.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:79.0) Gecko/20100101 Firefox/79.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



DEAR FRIEND


Compliment of the day to you. I am mrs.ALICE ARTHUR I am sending this brief
letter to solicit your partnership to transfer $9.3 Million US
Dollars.I shall send you more information and procedures when I receive
positive response From you. Please send me a message in My private
email address is ( mrs.alicearthur12@gmail.com )
Best Regards

mrs.ALICE ARTHUR.
