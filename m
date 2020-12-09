Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEE22D3F9C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Dec 2020 11:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgLIKLu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Dec 2020 05:11:50 -0500
Received: from mout.gmx.net ([212.227.15.18]:41939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729628AbgLIKLt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Dec 2020 05:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607508616;
        bh=ZW3LRjnsR/uh3hj6MP8AK4X3Js6kEReKKbZ7feovr2w=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:In-Reply-To:References:Date;
        b=GftNVg1MpXV+08AjEf0W4znpdTDrh90bT0YeDdBfl2LDt/6oK+4V0fz9K3QO719HY
         AbTQUlGvpc26wJHUjRaruA8xAtfyhUdG/VoSalSrG8tUzad4yvhtOGp3lyAdUXXSvu
         TbHaohH7e1+XCBkbIiU8cPTXDHIhKa0dvprbmId4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mobalindesk.lan.lan ([77.10.210.26]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAh0-1kFoWm0Sfg-00bYNe; Wed, 09
 Dec 2020 11:10:16 +0100
Message-ID: <1f78cd5d635b360e03468740608f3b02aea76b5d.camel@gmx.net>
Subject: Re: btrfs send -p failing: chown o257-1571-0 failed: No such file
 or directory
From:   "Massimo B." <massimo.b@gmx.net>
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <CAL3q7H7oLWGWJcg0Gfa+RKRGNf+d4mv0R9FQi2j=xLL1RNPTGA@mail.gmail.com>
References: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
         <CAL3q7H72N5q6ROhfvuaNNfUvQTe-mtHJVvZaS25oTycJ=3Um3w@mail.gmail.com>
         <d4891e0c7aa79895d8f85601954c7eb379b733fc.camel@gmx.net>
         <CAL3q7H5AOeFit_kz4X9Q2hXqeHXxamQ+pm04yA5BqkYr3-5e+g@mail.gmail.com>
         <40b352dfa84e0f22d76e9b4f47111117549fa3bb.camel@gmx.net>
         <CAL3q7H7oLWGWJcg0Gfa+RKRGNf+d4mv0R9FQi2j=xLL1RNPTGA@mail.gmail.com>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 09 Dec 2020 11:05:14 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SYOfmiOLhlVgRLicGI8iPoqD7WwPohCH98WgBntT8HZJh42+bgQ
 0nOnV2+kqVVzEAgsr2vYeM+TBBt9fKNYK8S/0VDrSuuHfied1IsnHnKjFsOdSafnM383UOJ
 AtdXWQIB1utHxhFpLJ3XCnCXgrdtErLmLW9KIoOleLwQKW9DQ59Hzu81y7YSmpTsHTlTAdy
 n1kM8JNF2Z6lSqNnrBZAg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Di9zTW6hzD4=:YiTDUgP7BwwXFo9zoR0uSs
 ZocWkCbL3xbc0++ytbzLZgN9oR57De6/1+OXc+Q4jltgDQ8doLPALVUzemdqlH5J1os5qzwB/
 2yECXRSGmbcSKea6kOPbQzDpVKMCEVIY2cksAlYLuK0NFWR7sKNGNtxgZse81/dJvOvtx5Wtc
 AT3Sn01qXrgEN/J0AecbsYHgbxlyGZD+GRkj3U6MretlqhIKAD8t8dj9OkJx5jCmsGuFTJ7s9
 qq/IwRfgZJiiddVil9A3Opp0UDiFGJ00cn/ceOtnE/xeXC+1YmkP3JvXxY5PQuayp4l/zOJTm
 sQEhfrWnHHTaPAe8PJUrEMiorNLdrWZfqWJsrFMUDy6cda1aFm9Ol2tfoEMAKNdSVYtx+s4rS
 xjpyy4sUyhaQkr2reATv0pNW+yZgNwePqFxYlEoXwM23yYoCwYq9WryyvM7MKlfSxuzSDJXh6
 UmXuU/MsBK0sztrJ1w2zfQ7QRsL/b6CX0l8BuRtX144ZFM3AHRiHKniuTJ0r+GbrUoVtW4crw
 BBkr0p6G/4s6P+lniD9hYRY5tn/mxxVoVwD3aHYpFr1p6BtsqXfvMctL5w3I3Y9TGf509VfR7
 04KT5zZ54Dd6BPHGDMD5UNpkxg/UbwqQGbv3s5cqrql0gBXLcKCVcsBN9V3ljiHEIi3dSoawm
 FO+bbwDtn8qt31k4lT/HgSnsa4bw9DwpAcNybWT9jchWRvdDRV9LTwS5grzoq98wN59OjeVK7
 spWxcU8ACemHvLbN9fAGvY5yTh1ncaiJtjqUBaUl91POGNIcPyqBb4nrbkXYwN85oIdQQ2qZT
 5KD8nGtmFkBz9BXt5Yu0welQJyZrz4TGqi4oQWQ/YeelR9L2OwR2k5RUboRyIv4hfjAaQx32r
 AhJgQAxFbKsOScphhvTA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2020-12-04 at 15:00 +0000, Filipe Manana wrote:
> Great, try this patch then:  https://pastebin.com/raw/8NcPVUb0
>
>
>
> I haven't had the time yet to craft a reproducer and confirm that is
>
> the case you are running into, but from the receive -vvv output you
>
> provided before, it seems clear what the problem is.

No, that is not working.
It does not fail anymore and looks like transferring as expected. But the
receiving subvolume is exploding and creating lots of sub directories. I k=
illed
the send|receive processes.

du is far bigger than the origin subvolume and reveals some of those subdi=
rs:

~ du -sh /mnt/local/data/snapshots/root/root.20180114T131123+0100/
du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+010=
0/o1568-359797-0': No such file or directory
du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+010=
0/o6060-359797-0': No such file or directory
du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+010=
0/o9279-359797-0': No such file or directory
du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+010=
0/o19075-359797-0': No such file or directory
du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+010=
0/o19076-359797-0': No such file or directory
...
du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+010=
0/o65078-359798-0': No such file or directory
du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+010=
0/o65084-359798-0': No such file or directory
du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+010=
0/o65095-359798-0': No such file or directory
22G	/mnt/local/data/snapshots/root/root.20180114T131123+0100/

compsize also reports about 20G referenced data.

The origin subvol has only 12G referenced.

Best regards,
Massimo

