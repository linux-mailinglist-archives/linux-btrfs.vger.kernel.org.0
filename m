Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC7273CD84
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jun 2023 02:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjFYANB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jun 2023 20:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjFYANA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jun 2023 20:13:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09A71BC
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jun 2023 17:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687651975; x=1688256775; i=quwenruo.btrfs@gmx.com;
 bh=20t4TWB2F1cOqSRyrwlxB88NrpWNfjxpZDPb4zOR+Hc=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=fhMRX/T22CIZRSp0nc6+kKCYE4EER7lu//HQkdNpTfVVFIv+N7XC8heTM0wxx3s+q6DV+fT
 3vc6rbT7Invp5Q7JgUcOnFSSesEkRnSrx6sRjvnlvabk2D9Aq5qo+m4gbR+y2KcYIoNby5XuG
 FwaEdpVcVht6SseOzgrhE5MD1NFI+8XdL3BhrKb+aWSAqAkZCFVzLVJW8aukZ9s+Da6YUQSs3
 I9e2qlX40R7zW+kmE5BS2N0uoAVARbRvFIPvh+ffyG8Vv9W5KgbYIF/YyIBb5HVfTUh322vB0
 GLSQiQ3iFtOw5iP4iGJbAqX72ZbBqBh+0M544S/PIO6iyq6an0zQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQeA2-1qOqNE3YG6-00NfnB; Sun, 25
 Jun 2023 02:12:55 +0200
Message-ID: <72cf8b25-d3b8-d113-a8de-d2c3aa822304@gmx.com>
Date:   Sun, 25 Jun 2023 08:12:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Btrfs shrink user failure
To:     notrandom98234 <notrandom98234@protonmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <7C4AZLXJxx6RBljNuhgqY7rfGiHUD9OZJKFLaR1MGbEzcvKSFAh_3arLVskVMfHkbnt7VA6y_YXbZg_eQ5R0UKSZytj_8X_yAUj8wXu40Ys=@protonmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <7C4AZLXJxx6RBljNuhgqY7rfGiHUD9OZJKFLaR1MGbEzcvKSFAh_3arLVskVMfHkbnt7VA6y_YXbZg_eQ5R0UKSZytj_8X_yAUj8wXu40Ys=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A7enwL0pu2fN6UYdl8UorJOoN/JEgBeWdHaubTlPpyY9SASBp2y
 VFn5yJHs8F5qfd28EGJwpODnZ4Cj9T0RQeOGL2/zxknhbn+lJZA68dZwQRIOHrS3tAQjgQN
 9VjY+yZLziGQJtmazEiMEf0wHezXQQZcbDX7v/TMuBGpMY3PihYmXJ/3qkiDi3JPe+BiiAE
 k9V+U/Eu4kPX1gVu2Xr6g==
UI-OutboundReport: notjunk:1;M01:P0:P5ZBHocM/x8=;+QMrxxV1y6pU1chIQTpHab3iCLS
 BBubu+JcUa3q7cnvBy8olq0Pyf/IqCOsh74z5Gbb9F0LeRkoNqgpa5MM5bFabWG7YjxIFuGv0
 mRLmvGgiKX1r5hrc5BucdSqeHtITSz0oF9lUOjcKCStOLFXvHk6kUVnkUNBa6m8YtzNmgqKx7
 dZiKihdkoypTSypJq8xzJdvz3ajWsSCTyHMVzwB+Ffq2ruQmORVxWrZAZEaB0c9AraRIV8skg
 +/PIBn+i0kHg8u3fO3XRF3TgbCfzmVgiy0ZipBk0KCw5S/duu6teqoXdht2YIlMPpfBaAHpPQ
 uO0XdI7gW9rXwO3gTiCbIgljPSccD7hW6EPaCBboCdcLnhK1tGj+44zaL120OvKpAx/WiDZ9M
 PW9fIoari8490poqboBNvZ0tEMqfTJ5BTMbtzUpj+LsDQWzTM7KIInx0Hsm7quHQE3GwQ+meW
 Q8n6MmP9jyNzlIGg7gmYNFSlLKURWWBeqCGmkAqaA5x+vIbKJwiVUdl8oU5JH8osvUNcdKlIH
 kkfnt6YpEXO7bc3rb2PG0E+CPS+GBAq0+6Bzld/aiOv7TYasasP8VMooVw7FqOGLFcH5lOrTD
 Tbql5y2OEZXRdHdbTie4Av2ZJtrI31F6Ss/OUwobPYkUC0/z5kgcXKP2nCzOTgorNTu9WPZY3
 ufiKQxDjvgXCm3GuVpyXcMMnjOF+ux+mLZAbyCWwqifgqpyRsBdgCTHItqBwom5XBnLoA9LGx
 NECLbCoZKoi381U9h3FWDMVFM7b+aAmo8RnQCrwYJwm+QsZKPmGbrcUmTZFNcbZDldKi1382t
 UfegScxk6fHtjrJl4LtpTbPlVEG4USV2SF/sMNp+UHUrrB2pbGKwpUoWSQsLpaVN2NRw7U0dV
 pBWbNuUsUyRskj7HEp3Y0Xgm8+TcMDmb6HZtO6gZ+Z+INWVHKNPW3HiBI6Fv4aKYDtUS8bgCW
 E/+GOwnvT407R6S5J/w8cG4avUo=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/25 07:46, notrandom98234 wrote:
> Hi,I shrank my btrfs too much, and now=C2=A0btrfs seems to be missing 2.=
1 MB of data at the end.
>
> [23368.040870] BTRFS: device label endeavouros devid 1 transid 22521 /de=
v/dm-0 scanned by (udev-worker) (144690)[23463.852308] BTRFS info (device =
dm-0): using crc32c (crc32c-intel) checksum algorithm
> [23463.852342] BTRFS info (device dm-0): using free space tree
> [23463.877154] BTRFS error (device dm-0): device total_bytes should be a=
t most 442379534336 but found 442381631488
> [23463.877187] BTRFS error (device dm-0): failed to read chunk tree: -22
> [23463.878731] BTRFS error (device dm-0): open_ctree failed
>
>
> Opening filesystem to check...Checking filesystem on /dev/mapper/luks
> UUID: ed20b6bd-ac51-403a-b2d6-3797de4ea122
> [1/7] checking root items
> [2/7] checking extents
> ERROR: block device size is smaller than total_bytes in device item, has=
 442379534336 expect >=3D 442381631488
> ERROR: errors found in extent allocation tree or chunk allocation

You can try "btrfs rescue fix-device-size /dev/mapper/luks".

If not work, please provide the following output:

# btrfs ins dump-super /dev/mapper/luks

# btrfs ins dump-tree -t chunk /dev/mapper/luks

Thanks,
Qu

> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 98553413632 bytes used, error(s) found
> total csum bytes: 95213404
> total tree bytes: 829259776
> total fs tree bytes: 661422080
> total extent tree bytes: 47677440
> btree space waste bytes: 163491925
> file data blocks allocated: 187938603008
>  =C2=A0referenced 111398690816
>
> btrfs-progs v6.3
> Label: 'endeavouros' =C2=A0uuid: ed20b6bd-ac51-403a-b2d6-3797de4ea122
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Total devices 1 FS bytes used 91.78GiB
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A01 size 412.00GiB used 96=
.02GiB path /dev/mapper/luks
