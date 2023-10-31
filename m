Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3657DD0B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 16:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbjJaPkf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 11:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345067AbjJaPke (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 11:40:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CE8C1
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1698766828; x=1699371628; i=jimis@gmx.net;
        bh=1aGmaBOu2Kl7BuHDCBLcUaPM9iuuJjo6PXflPcaTvzA=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=K97I66VcVJZKROWaGygeF/whq68EESmHpCpg6gB4t8KnhvLS7bFMxhjLguroHUR+
         Eldy7sW8/LGlrLpBMjgCjuCwAHxtMdrZNRE3zTOZrc2FXdGjSEEVLeR896XX12yfK
         lmX0fL7TC4C9Fuf9LuEV3VRzJ00uU7fpEMaffq1Po2HL+m6wHWFrRc4LRLDc+Kjfd
         JjvqfsUop0e2n1cc+35AVeQ2G9cKeyeK/4mH0704Mf/xRFM/l5crjpedbmX2FJOWi
         72uieTtZmvmf0JHciwhy7w1QtDHSHzFI+2CgKQd+H5PSPwD/2+Wdv7lsxfGBXNfRz
         v2VHkQ9//1SeMNwsgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.65] ([185.55.107.82]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQic-1r8KR02o5u-00ATIp for
 <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 16:40:28 +0100
Date:   Tue, 31 Oct 2023 16:40:27 +0100 (CET)
From:   Dimitrios Apostolou <jimis@gmx.net>
To:     linux-btrfs@vger.kernel.org
Subject: Slow speed when doing sequential read() with 8192 block size from
 a compressed file
Message-ID: <fd9ad68d-a87a-dce0-0087-40d43e66218b@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Provags-ID: V03:K1:Svcd6aEQBXG1d4T//HjPLUup/ZfuK+RcVwPRZdJ1ID9BhGgw3r8
 SOv4gGb8F/8bbSoIygzqVAZPf7pISJvDHnDJdxowc3qnzlQ6appX8pCTQyT9uYcix6FJ4SI
 39U70WBnXNT6XabWFwtQxA0c3LJjaSaYQPeIDtnHw1fbcjlp7xd2BjFYhJ+dUKANShpCA4R
 e6bjSLAai4EBtrcFuhnPA==
UI-OutboundReport: notjunk:1;M01:P0:M0xR3oS4D9Y=;Q6E7VgJOgM7r6fyM9yag80YCa47
 /WzIuVrdA3SpoirLSxCUrh3e+eWqyPllZQNrh6f+6+R5eTVmB+wgHc0YX4GsXrNuhS893j8cD
 xNc+DbNUAizwCTBjOFL+aE/6qUl9cih+L7Ezgh1WeNC0J6TCKvbG8H4UIz5rOo4OG9hl7Heqb
 HoXp1NGyZZ4GKYnEih/6bhE3f4iQWqLr/zoU880pZq/2v5f7Hf9th0c0w98MTgEj0BxwKpC8o
 ByfLnBKAqO+dMsY7MMnmJ8b85dgV8t84sLEfChee8k2MzAhj9UaBfT0X+h1slafzrSlxwkyr5
 b+hBgsQYJnqE33SpBnSQxVTMBtIRGhDTicJTN0BOQWzaVw+gk3d8gALpYXehf2hZ7nvoYaYRm
 iLB0H1BCF2W1baHD8Le/alArYY2tAxyCR8wB7UsKiTcr6wOVYB1qpYI2G5aBn3xl9r4bPo9Tn
 SepZm5u9nYoKyzc6faRlfsbUePDCln6xA05o8B1nvtqIjcKEI5WBwcSWmAqW8fJEc7zO1L8ch
 3ZdCvxUQ97cG8siUsbPYr9cLxoZ0IKEVTUkElLFkhWaZeyojs5+kjjNU/J6H5j79Cts247ynN
 65j1OwNY4SMhONdZDvYuzgE2FFGZ/AX80CmhApEklPuCghNG3StcjXipPsTTcXTEvE1YiK/7o
 ou5VeA1EgGMit6dG5yZzIQ4dVLQea4ameQzPI7PkULkcZtZDUzviP+9QSZ122l+7ZvzWT5MDr
 YRBrmgLqv45VS5A864FXI8yQFiKmsaTKrQKPxQcrADDrOpGTUqZ/jTOfOFLk/8+V3lTGPxyJT
 uiAUHbEYZIObcMl6r9ou1MN1hsWDdw91E1wqg7oAxY4sItNMHJkiuvQWOMXMs9G3peFyII40q
 ExhFOQHRYfJt0NJ83ADPbQcFScFsLx6RAoCqx6uoHTRJlg1/sAdREQQAm
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello list,

I have btrfs configured to do zstd:3 compression. Here is the simplest
command I'm using to sequentially read a big file:

   # dd if=3DFILENAME of=3D/dev/null bs=3D8k

The device I/O speed limit had been measured at 200 MB/s. Using iostat
while running the above command, I'm seeing much lower speeds, varying
8-60 MB/s. CPU is not the bottleneck either, as the CPU is powerful enough
to decompress zstd at much higher rates.

NOTE: Running the same command with an uncompressed file
       saturates the device's bandwidth!

Is it a bug in Btrfs? Can you replicate these findings?


Thanks in advance,
Dimitris

P.S. Increasing the blocksize is not really possible, as this
      is a contrived example that only replicates the behaviour of another
      application.

