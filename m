Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8ECBA141
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Sep 2019 08:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfIVGfB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Sep 2019 02:35:01 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40663 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfIVGfB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Sep 2019 02:35:01 -0400
Received: from jupiter.fkoop.de ([79.231.199.16]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MOz8O-1iZ52t2CgG-00PKPp for <linux-btrfs@vger.kernel.org>; Sun, 22 Sep 2019
 08:34:59 +0200
Message-ID: <57e3a3a2c40fe7ea33ff85aec59ffaefdd20f3e6.camel@fkoop.de>
Subject: help needed with unmountable btrfs-filesystem
From:   Felix Koop <fdp@fkoop.de>
To:     linux-btrfs@vger.kernel.org
Date:   Sun, 22 Sep 2019 08:34:40 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:U5XWyDmXymBA6OTHBcImBsM5DJPzzP2Lmr6ViFxCvA0MbTbS4RD
 E51zPvAe3FmAqJIk4q6Ya9GcNDRX1Dxyw9jP1SRHHXB4I3iLN8iBBeGd/uV5ffcuzhup62G
 kZbK4CUqkKcbUqp3oid7v7+NYhiUnxjKyUYaCZYhWP5PAoBiQ7gliEPlj9JV5qtGTsPAnLN
 uS4p7Cbnk6jOeBkZvAsLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zoiRjCSW2zQ=:UIo6CUYiMVxS4Wkw0VXdYL
 B9eyeiLVLMtwT96I5VDpatnOe8xuAO0JwGZLn27YJFNsgwhYccsUTDkOLHzFKAVyhEVn/Sxxn
 iZb6q2pJ/+Ovu44KZAZIs0IDO1QuRzD2/89TrS7A7Zx3ksELn/f+dDF1rt1ZSy+v0SvqB77MO
 GWYDi4EXauwjFqae9ALEgSTghRDxOtiST5GmhrxHejqxwOXv8+mX5p2F2+8r7GsmGPmlhqWg8
 eYkn1Ul+ecNEIwWt0AEOT4wrClBJGYwb7/od0kyuuMDnGKbzHlEeHV1A3XJfNcLbttqBSYUQS
 nSXGWTaPc9CsDLy1ZV8F6gavFLlHfJtzY5x5a+F3rQ3R2ITvby5/My/uBGIfW9uwW0eL8db3J
 ku1z1bGU5PkojnKz2sa+D3Vfw35lgjSZTwYKlYhl5w+JTxzcxOIh8VNnHzcANI2lQin1x+6kp
 dxWsxvwDayFSbzhxp55yzQMwXEfVyifUqNatvGuFv6k4yeRtT86sSBPU1LfIfWJfXi5jTvoKR
 mqsX82yBWbxslCg7pC9JmBuIZXTDWCIHqP6Y+fadufAN8miLuEQVh/RI6r3f2Eo502R4trC6x
 JXeINiZmFiKFJfMuBdAYQfuH7n7cucwtU+SqGLw1uV9hQbEgL2jZv5NOYI3Y2/mM4z5klhhPN
 sIHfmngO2x2VHnYoVd7+/4ueNan9xH2Lrc44EDrnYE4XrKZb3ROW0qvKjLTsM33uICG3x0LFe
 9xtdhHlByXUxtRCB6EjrsM92X0VrjhXRao4ecuZTAXZPu3urzIm8LhukHuFc4VG8vmDN9GtVT
 HiKFsmF3xjI4pz8gHJBbOFmpxF44dno5F4cor4Me/9mRBqfJIGhhxSRNPMmHR7ef7kGWA6bC+
 LNC5U/mUtW3Xl5tBk64fWDhIvUFwTFlFtViQDjMDm/tpYXKqZPX4wqNiSR1rdSMzvKm1R6iX9
 X1M9kxg7focTJk2v4Scu+WuxxE0QmQQo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I need help accessing a btrfs-filesystem. When I try to mount the fs, I
get the following error:

# mount -t btrfs /dev/md/1 /mnt
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/md1,
missing codepage or helper program, or other error.

When I then try to check the fs, this is what I get:

# btrfs check /dev/md/1
Opening filesystem to check...
No valid Btrfs found on /dev/md/1
ERROR: cannot open file system

Can anybody help me how to recover my data?


-- 
Mit freundlichen Grüßen

Felix Koop
fkoop@fkoop.de

