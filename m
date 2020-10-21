Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF4B294A20
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 11:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408898AbgJUJEp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 21 Oct 2020 05:04:45 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40577 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408842AbgJUJEk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 05:04:40 -0400
Received: from [192.168.177.20] ([91.63.161.114]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1M5xDJ-1kWVlU09f9-007RmD for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020
 11:04:39 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: parent transid verify failed: Fixed but re-appearing
Date:   Wed, 21 Oct 2020 09:04:36 +0000
Message-Id: <em2ffec6ef-fe64-4239-b238-ae962d1826f6@ryzen>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.37929.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Aksw7CYe2ebKfTasoZLWW2GKHzIuN8CFJ5xreustkMPqOxDDN4x
 IE7vfRQQnvNOR7GLsxRf74x/sTLIL7vThtikiHQcOWOVOW6HenzDTqMq6Y7+vzlultyq8w7
 lWYUFZ3ItMmgXe3y4LCRcTZuijZcP1HAo1CFEcZ5DWj9geWNmjZ9iE27gXCgT6+pqFQfYDt
 FkCO4QWA8epxaC4bBhSng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vHqiOfy6/yM=:ZYAa8r3ZXAwDlBtdezuEEp
 w0y/YOrMlO6Jmo/lSfDOm4VypiRkEXdiu5SnBcspPMqi8VD5HXrkiV4s7ThxQRn6frUnQL8J8
 T5yLjUm3oip+MywPoyZMMSoWZpRTZx92NKDGNTZpKX/f57upNBVDwtmhJY++WyM77dD7tOeFP
 3R0EAIxXi/CCa2CClKT6Yy0eyaTSWV6Yo7Ubzmfc7jbbdyEvVa/zOw6VX8dX+RtfIjw/HPkPD
 nZSwnrar2V8Ns9TO8zPfi69rjYT35dsN9SsiwtiQ6PTkDWCtzk5zS/3ZuCqW1qvVmNNaduEC+
 /0J1Tl0EzbtHyBQlTGkON2DiwhU1GZP1WFPwd93gVWRrys69WkLIU0RCXrhlHNH3KbBN6/HOa
 sRasROxFPUT2Ue60VNKtoFliut1FFM1C9sMEzc+nY1UMaS1FbzgkvOBctGA+IzuF7Io3qdRhO
 5a7H1UpPuQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I have a re-occuring issue with my btrfs volume.
I am using dduper (https://github.com/Lakshmipathi/dduper/issues/39).
When running it, I get:
parent transid verify failed on 9332119748608 wanted 204976 found 204978
(reproducable when running the same dduper command)
I cured that by unmounting and
   mount -t btrfs -o nospace_cache,clear_cache /dev/sda1 /mnt/test

After that, I was able to run that dduper command without a failure.
But some days later, the same command resulted in:
   parent transid verify failed on 16465691033600 wanted 352083 found 
352085

again.

A scrub showed no error
  btrfs scrub status /dev/sda1
scrub status for c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
         scrub started at Mon Oct 19 21:07:13 2020 and finished after 
15:11:10
         total bytes scrubbed: 6.56TiB with 0 errors

Filesystem info:
  btrfs fi show /dev/sda1
Label: 'DataPool1'  uuid: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
         Total devices 2 FS bytes used 6.56TiB
         devid    1 size 7.28TiB used 6.75TiB path /dev/sda1
         devid    2 size 7.28TiB used 6.75TiB path /dev/sdj1

The system has a USV. Consequently, it should not experience any power 
interruptions during writes.

I did not find any indications of it in /var/log/*
(grep  -i btrfs /var/log/* | grep -v snapper |grep sda)

What could be the reason for this re-appearing issue?

Regards,
Hendrik

