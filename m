Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78D7312D99B
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Dec 2019 16:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfLaPER (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Dec 2019 10:04:17 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:44644 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfLaPEQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Dec 2019 10:04:16 -0500
Received: by mail-ed1-f42.google.com with SMTP id bx28so35410530edb.11
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Dec 2019 07:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:autocrypt:message-id:date:user-agent:mime-version;
        bh=P22ev2b9aajxz55TKEBObzpD1wZLUdn4BVErOhN0GcA=;
        b=uKE+JQplxUUKRsDQwZExYP/GARF4DKyieFyxF508Hr/uvAwzSTO9zBUcl+fFEIOlkJ
         L/QwwbtGtuAIFOhKyYgnpznkV3I9qYsa5nhlBawt0sYAbnK+H9dYHSFeN2E6+re+Gz0w
         voBmpb0ZLQArYz2qBuBKwIxoJsTAg0safnHqWzrRdIoeI/4Gbg+k/+0EoObEhnx6hAf4
         +3BKN37WWAbFzuINyEXnD3U2bthKBBnnK8h/K8DWa7F6hMfjGLdkXoxOUJzkjbRfJdFJ
         tkKnCT5ljMQkC37rprlPPiQOvRUfTPjwNkHxX3ZiUOj6vN4fK4AMdZCWvOkhmScbCWiD
         NIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version;
        bh=P22ev2b9aajxz55TKEBObzpD1wZLUdn4BVErOhN0GcA=;
        b=Ta1MeSmwcBccL+R35xj7DV7W0UFzSXUfu1WTBCQTtSc1hQIvs/q97dkOMktLDiZ459
         P4uvJK7snIxaNQHVc4DOZxhUkcjxjENFH33XzSnUg5FQ7m7lIO5RlE/sDb5taivXxjhP
         DPW37x2HunkbGPNERVYyy2uD6f8RzvTI/DtW5/6hi5Jox92WLfAyFe7sDi7YzF6JVGpZ
         mvqrEkQhNP7D3c6MXF4qrM2+TBHQrNhQvGDiwCvgFeXsl3tS+8P7w70kT26Ztzk6DQ9g
         RnAgyMSWPEINEmlpV/++htDOk19on706VDlOGx/16uTce76DI6Wu85iIIzYCd9FfzND0
         1KBA==
X-Gm-Message-State: APjAAAXtl9IYss0522eYkjvxx3pjzSgigN0jHHLxFZVfvA7R19XT2Sci
        ksxsJN1QPMmItSgU9PPj7hGhboGh
X-Google-Smtp-Source: APXvYqzKnhauLyt0eZj2p41rI5Ym5EIJrMN+I4JHrOkfjFXCWu12TX5/T4lZKjeXGGWagX3XzjsQ3w==
X-Received: by 2002:a05:6402:28d:: with SMTP id l13mr74096339edv.236.1577804654318;
        Tue, 31 Dec 2019 07:04:14 -0800 (PST)
Received: from [192.168.14.56] (mue-88-130-92-235.dsl.tropolys.de. [88.130.92.235])
        by smtp.googlemail.com with ESMTPSA id q11sm6215529ejt.64.2019.12.31.07.04.13
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2019 07:04:13 -0800 (PST)
To:     linux-btrfs@vger.kernel.org
From:   Ole Langbehn <neurolabs.de@gmail.com>
Subject: repeated enospc errors during balance on a filesystem with spare room
 - pls advise
Autocrypt: addr=neurolabs.de@gmail.com; prefer-encrypt=mutual; keydata=
 mQGiBELi5x8RBACTGJvigUyuTnZw57+evWAPnKkUPyc10mfIxxdb9LubuGdu/wY/GNv8JN5x
 LRgTW1a0e2832wwPqNxge5askrwRYqz9upMdZThHV3GwTdd8X+6SQONR9Sh6VPHskMd0lDuJ
 H7lyyjzd0dsO5B3jU2Or8wyFJIT24qJAERNSegjfQwCg2X0wqrydxGacWSG1gSZolOruC5sD
 /inO3AYHyrqnFcqp8XqVnG2TbMCt80/g+t4B8rfH8s1Tsqu/Ls/H6fj9uyz48+BbcjDcOVEg
 +BJCvZZYaBvd13ALItjw/hKyjdB5E1hbdPO2Y64RQtXl9lKaQsKwWGvfkO8BY1Q04F3gboGc
 RSX40rQQ3iXJKg3WtU2eG1TYAmYeA/49+eal3mVe1PWL+UDMKDaY1dgSSS7x2aPgSTU6QUQW
 A53s79otUUW4Xrpt4/oVUmXiXBpB49kFlQupO3lUzZ/QXf40cQonc+lAwS1dWlvvlnzQrLd1
 ieG1cg0dDNUp6/lzytUqDyBrnngzcVzqC3rQRrFF7QPCHoH5wZzZsWCuHrQ5T2xlIExhbmdi
 ZWhuIChzZWNvbmRhcnkgcHJpdmF0ZSkgPG5ldXJvbGFicy5kZUBnbWFpbC5jb20+iGIEExEC
 ACIFAkwwXnwCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEKMYFNw/P7oRzk4AoKQY
 GdPt6oPDixWzH0FC3b9nMl68AKCjxx843gMxpFj625sHcwRBZp8b1bkCDQRC4udyEAgAp++N
 0t2qtC3+rzQelEJ75CZXm3g++HsvYloq3/NwyBt3DtDQQ8hKzVBMu1EWv7SrL1JcJsCIKMhi
 WUz1sn7jRYzjGdS89b+fy49ckvDYmY+/h5A8kIwxJrnk2or3xVKpJe8WJhZFCo+wd46izR1x
 4x3mkN70DqOIR2hFS/61mWz0Vl5QgiFbeax7o6Ns+hX3U4doBFbayL9zLajlIGnoIP3g9iwR
 OZ64NG9iWuDpDfwspKzKMLTSEfBDPBW5liUFpuEAN9Q3/25kU+RtpguaDCFzo8RAfVxPsnWi
 QnAS2P8+1J2Cvef8mVZkAObWwPD+qC9kpxxuMdthM2KpbBccTwADBQf/X7Y8OqL+DuwWjZ61
 4tBx5gTT0qclHaoAoIgZbDHjxhV05Bo8R/buCq4xKqLLor2kN8YyOv6zm3N95zTYOVAaXCLc
 9q2H8EvkkHSL7t/iLFHeMVQZIBaQKzwR8eBTo3Tn3Us+/KIlp5XZwHviaDSf5LuGxvP539yM
 m5rYigml6YeRx7m8BeLzuew3icyRSzhJ+v/93W4ZOmYhOQxTbcHZ+sIA1ZG1zR0HDrQ9pNYP
 MJYFrVrMO7BNdxAkitUpJis4lNJskf8ZbtZAX1jSykEnw8FFJHG9nD3sbJPHDRPqbTUwlc3P
 twhIKd8BkbiGDmBDGMMLEiVKCmOvmcXztBCgI4hJBBgRAgAJBQJC4udyAhsMAAoJEKMYFNw/
 P7oRQcsAn2bNrSFKEo+BjRjsop2hLPdhWJJ/AKCmytKxEQy0s1iKiIbshDWFevjd2A==
Message-ID: <495cfb98-7afd-a36d-151b-d7cc58f1d352@gmail.com>
Date:   Tue, 31 Dec 2019 16:04:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2yDYDMMx6QB1yPxe06vpx5OPJL0aiBb1d"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2yDYDMMx6QB1yPxe06vpx5OPJL0aiBb1d
Content-Type: multipart/mixed; boundary="Cmrt1tFJywc4v3tRneh6LJHLwAIxt6zV4"

--Cmrt1tFJywc4v3tRneh6LJHLwAIxt6zV4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

I have done three full balances in a row, each of them ending with an
error, telling me:

BTRFS info (device nvme1n1p1): 2 enospc errors during balance
BTRFS info (device nvme1n1p1): balance: ended with status: -28

(first balance run it was 4 enospc errors).

The filesystem has enough space to spare, though:

# btrfs fi show /
Label: none  uuid: 34ea0387-af9a-43b3-b7cc-7bdf7b37b8f1
        Total devices 1 FS bytes used 624.36GiB
        devid    1 size 931.51GiB used 627.03GiB path /dev/nvme1n1p1

# btrfs fi df /
Data, single: total=3D614.00GiB, used=3D613.72GiB
System, single: total=3D32.00MiB, used=3D112.00KiB
Metadata, single: total=3D13.00GiB, used=3D10.64GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

This is after the balances, but was about the same before the balances.
Before them, data had about 50GB diff between total and used.

The volume contains subvolumes (/ and /home) and snapshots (around 20
per subvolume, 40 total, oldest 1 month old).

My questions are:

1. why do I get enospc errors on a device that has enough spare space?
2. is this bad and if yes, how can I fix it?



A little more (noteworthy) context, if you're interested:

The reason I started the first balance was that a df on the filesystem
showed 0% free space:

# df
Filesystem     1K-blocks      Used Available Use% Mounted on
/dev/nvme1n1p1 976760584 655217424 	   0 100% /
=2E..

and a big download (chromium sources) was aborted due to "not enough
space on device".

I monitored the first balance more closely, and right after the start,
df looked normal again, showing available blocks, but during the
balance, it flip-flopped a couple of times between again showing 0
available bytes and showing the complement between actual size and used
bytes. I did not observe this behavior any more during balance 2 and 3,
but did not observe as closely.

TiA for any insights and ideas on how to proceed and a healthy start
into the new year for everyone.





--Cmrt1tFJywc4v3tRneh6LJHLwAIxt6zV4--

--2yDYDMMx6QB1yPxe06vpx5OPJL0aiBb1d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSXTCBs9o76qfz+ccijGBTcPz+6EQUCXgtjZwAKCRCjGBTcPz+6
ESs5AKCiAKkrDOCjdEET+YLmW7J7MsztOQCdG/tSxX8BKMlLp+Cozal01PcBz0k=
=34g4
-----END PGP SIGNATURE-----

--2yDYDMMx6QB1yPxe06vpx5OPJL0aiBb1d--
