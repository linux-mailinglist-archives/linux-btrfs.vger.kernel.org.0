Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7322EC2C71
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 06:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfJAEIp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 00:08:45 -0400
Received: from forward102j.mail.yandex.net ([5.45.198.243]:42485 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbfJAEIp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 00:08:45 -0400
Received: from mxback16o.mail.yandex.net (mxback16o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::67])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id 62922F21574;
        Tue,  1 Oct 2019 07:08:40 +0300 (MSK)
Received: from myt1-e9eae5d2de9d.qloud-c.yandex.net (myt1-e9eae5d2de9d.qloud-c.yandex.net [2a02:6b8:c00:1290:0:640:e9ea:e5d2])
        by mxback16o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id f9p3EB2FCS-8enSI4cv;
        Tue, 01 Oct 2019 07:08:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1569902920;
        bh=kF1t2Cg/HRptBUW3Y4ze3+AZ80VFNqvwu3opaHjikkQ=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
        b=optd7C15o1sm0UZdt94LyhEOtq35YOObNCV84inhXU4y7ptkozCVXpTOGCk0KxYoW
         ivg/Rgk2pGDhdFoemo46jD51oOiF5LLNFYs6t30jw8Xb2aVb2VBa4pIaIzE6NYFKUm
         GWlPnhmpGfHHyy8vaB/zxrnoRvMirxpgvtvRGxnw=
Authentication-Results: mxback16o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt1-e9eae5d2de9d.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id 3vJqUlSwGE-8dHSXkqi;
        Tue, 01 Oct 2019 07:08:39 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: Btrfs partition mount error
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
 <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
From:   Andrey Ivanov <andrey-ivanov-ml@yandex.ru>
Message-ID: <b0ec0862-e08c-677d-8bf4-8a87b74c1ec2@yandex.ru>
Date:   Tue, 1 Oct 2019 07:08:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
Content-Type: multipart/mixed;
 boundary="------------FDD8E4153616A7790C96F612"
Content-Language: ru-RU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------FDD8E4153616A7790C96F612
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.09.2019 9:27, Qu Wenruo wrote:
> I recommend to do a "btrfs check" on all fses.

I had done "btrfs check" on /dev/sda4:

attached btrfs-check-sda4.output

There are some errors. How to fix them?

--------------FDD8E4153616A7790C96F612
Content-Type: text/plain; charset=UTF-8;
 name="btrfs-check-sda4.output"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="btrfs-check-sda4.output"

WzEvN10gY2hlY2tpbmcgcm9vdCBpdGVtcwpbMi83XSBjaGVja2luZyBleHRlbnRzCmluY29y
cmVjdCBsb2NhbCBiYWNrcmVmIGNvdW50IG9uIDE1MzM1MzgzMDQgcm9vdCA1IG93bmVyIDc2
NjI0ODIgb2Zmc2V0IDAgZm91bmQgMSB3YW50ZWQgNDE5NDMwNSBiYWNrIDB4NTViYmIzZjQ4
MmEwCmJhY2twb2ludGVyIG1pc21hdGNoIG9uIFsxNTMzNTM4MzA0IDE2Mzg0XQpkYXRhIGJh
Y2tyZWYgMTUzMzc1OTQ4OCByb290IDUgb3duZXIgMTAxMjI2MDkgb2Zmc2V0IDAgbnVtX3Jl
ZnMgMCBub3QgZm91bmQgaW4gZXh0ZW50IHRyZWUKaW5jb3JyZWN0IGxvY2FsIGJhY2tyZWYg
Y291bnQgb24gMTUzMzc1OTQ4OCByb290IDUgb3duZXIgMTAxMjI2MDkgb2Zmc2V0IDAgZm91
bmQgMSB3YW50ZWQgMCBiYWNrIDB4NTViYmIxYzc2ZTQwCmluY29ycmVjdCBsb2NhbCBiYWNr
cmVmIGNvdW50IG9uIDE1MzM3NTk0ODggcm9vdCAxNjM4OSBvd25lciAxMDEyMjYwOSBvZmZz
ZXQgMCBmb3VuZCAwIHdhbnRlZCAxIGJhY2sgMHg1NWJiYjNmNDlkMDAKYmFja3JlZiBkaXNr
IGJ5dGVuciBkb2VzIG5vdCBtYXRjaCBleHRlbnQgcmVjb3JkLCBieXRlbnI9MTUzMzc1OTQ4
OCwgcmVmIGJ5dGVucj0wCmJhY2twb2ludGVyIG1pc21hdGNoIG9uIFsxNTMzNzU5NDg4IDQw
OTZdCmRhdGEgYmFja3JlZiAxNTM0NzEzODU2IHJvb3QgNSBvd25lciA3MzEyMzk2IG9mZnNl
dCA0MDk2IG51bV9yZWZzIDAgbm90IGZvdW5kIGluIGV4dGVudCB0cmVlCmluY29ycmVjdCBs
b2NhbCBiYWNrcmVmIGNvdW50IG9uIDE1MzQ3MTM4NTYgcm9vdCA1IG93bmVyIDczMTIzOTYg
b2Zmc2V0IDQwOTYgZm91bmQgMSB3YW50ZWQgMCBiYWNrIDB4NTViYmFjN2U4YWQwCmluY29y
cmVjdCBsb2NhbCBiYWNrcmVmIGNvdW50IG9uIDE1MzQ3MTM4NTYgcm9vdCAyNzQ4Nzc5MDY5
NDkgb3duZXIgNzMxMjM5NiBvZmZzZXQgNDA5NiBmb3VuZCAwIHdhbnRlZCAxIGJhY2sgMHg1
NWJiYjNiZTgzYzAKYmFja3JlZiBkaXNrIGJ5dGVuciBkb2VzIG5vdCBtYXRjaCBleHRlbnQg
cmVjb3JkLCBieXRlbnI9MTUzNDcxMzg1NiwgcmVmIGJ5dGVucj0wCmJhY2twb2ludGVyIG1p
c21hdGNoIG9uIFsxNTM0NzEzODU2IDQwOTZdCmJhY2tyZWYgYnl0ZXMgZG8gbm90IG1hdGNo
IGV4dGVudCBiYWNrcmVmLCBieXRlbnI9MTk4NTA1MjY3MiwgcmVmIGJ5dGVzPTIwNDgwLCBi
YWNrcmVmIGJ5dGVzPTg2MDE2CmJhY2twb2ludGVyIG1pc21hdGNoIG9uIFsxOTg1MDUyNjcy
IDIwNDgwXQpFUlJPUjogZXJyb3JzIGZvdW5kIGluIGV4dGVudCBhbGxvY2F0aW9uIHRyZWUg
b3IgY2h1bmsgYWxsb2NhdGlvbgpbMy83XSBjaGVja2luZyBmcmVlIHNwYWNlIGNhY2hlCls0
LzddIGNoZWNraW5nIGZzIHJvb3RzCnJvb3QgNSBpbm9kZSA4NDMwNjUgZXJyb3JzIDEwMCwg
ZmlsZSBleHRlbnQgZGlzY291bnQKRm91bmQgZmlsZSBleHRlbnQgaG9sZXM6CglzdGFydDog
MCwgbGVuOiA0Mjk0OTcxMzkyCgl1bnJlc29sdmVkIHJlZiBkaXIgODQzMDYzIGluZGV4IDMg
bmFtZWxlbiAxMyBuYW1lIFRlbXBsYXRlcy5tc2YgZmlsZXR5cGUgMSBlcnJvcnMgNCwgbm8g
aW5vZGUgcmVmCgl1bnJlc29sdmVkIHJlZiBkaXIgODQzMDYzIGluZGV4IDMgbmFtZWxlbiAx
MyBuYW1lIFRlbXBsYXRlcy9tc2YgZmlsZXR5cGUgMCBlcnJvcnMgMywgbm8gZGlyIGl0ZW0s
IG5vIGRpciBpbmRleAoJdW5yZXNvbHZlZCByZWYgZGlyIDg0MzA2MyBpbmRleCA1IG5hbWVs
ZW4gNiBuYW1lIERyYWZ0cyBmaWxldHlwZSAxIGVycm9ycyA0LCBubyBpbm9kZSByZWYKCXVu
cmVzb2x2ZWQgcmVmIGRpciA4NDMwNjMgaW5kZXggNSBuYW1lbGVuIDYgbmFtZSBEc2FmdHMg
ZmlsZXR5cGUgMCBlcnJvcnMgMywgbm8gZGlyIGl0ZW0sIG5vIGRpciBpbmRleApyb290IDUg
aW5vZGUgODQzMDY4IGVycm9ycyA0MDAsIG5ieXRlcyB3cm9uZwoJdW5yZXNvbHZlZCByZWYg
ZGlyIDg0MzA2MyBpbmRleCAxNSBuYW1lbGVuIDE0IG5hbWUgZmlsdGVybG9nLmh0bWwgZmls
ZXR5cGUgMSBlcnJvcnMgMiwgbm8gZGlyIGluZGV4Cgl1bnJlc29sdmVkIHJlZiBkaXIgODQz
MDYzIGluZGV4IDE4IG5hbWVsZW4gOCBuYW1lIFNlbnQuc2JkIGZpbGV0eXBlIDIgZXJyb3Jz
IDIsIG5vIGRpciBpbmRleApyb290IDUgaW5vZGUgOTA4NjI0IGVycm9ycyAxLCBubyBpbm9k
ZSBpdGVtCgl1bnJlc29sdmVkIHJlZiBkaXIgODQzMDYzIGluZGV4IDE1IG5hbWVsZW4gMTQg
bmFtZSBmaWx0ZXJsb2cuaHRtbCBmaWxldHlwZSAxIGVycm9ycyA1LCBubyBkaXIgaXRlbSwg
bm8gaW5vZGUgcmVmCnJvb3QgNSBpbm9kZSA5MDg2MjcgZXJyb3JzIDEsIG5vIGlub2RlIGl0
ZW0KCXVucmVzb2x2ZWQgcmVmIGRpciA4NDMwNjMgaW5kZXggMTggbmFtZWxlbiA4IG5hbWUg
U2VudC9zYmQgZmlsZXR5cGUgMiBlcnJvcnMgNSwgbm8gZGlyIGl0ZW0sIG5vIGlub2RlIHJl
Zgpyb290IDUgaW5vZGUgNzI4NzMyOSBlcnJvcnMgMTAwLCBmaWxlIGV4dGVudCBkaXNjb3Vu
dApGb3VuZCBmaWxlIGV4dGVudCBob2xlczoKCXN0YXJ0OiAwLCBsZW46IDgxOTIKRVJST1I6
IGVycm9ycyBmb3VuZCBpbiBmcyByb290cwpPcGVuaW5nIGZpbGVzeXN0ZW0gdG8gY2hlY2su
Li4KQ2hlY2tpbmcgZmlsZXN5c3RlbSBvbiAvZGV2L3NkYTQKVVVJRDogYTk0MmI4ZGEtZTky
ZC00MzQ4LThkZTktZGVkMWU1ZTA5NWFkCmZvdW5kIDE4NDQ3MTY2MjU5MiBieXRlcyB1c2Vk
LCBlcnJvcihzKSBmb3VuZAp0b3RhbCBjc3VtIGJ5dGVzOiAxNzg4NDM0MzIKdG90YWwgdHJl
ZSBieXRlczogMTE3Mjc4MzEwNAp0b3RhbCBmcyB0cmVlIGJ5dGVzOiA5MjE3OTY2MDgKdG90
YWwgZXh0ZW50IHRyZWUgYnl0ZXM6IDUyMjMyMTkyCmJ0cmVlIHNwYWNlIHdhc3RlIGJ5dGVz
OiAxODQwNDEwNzgKZmlsZSBkYXRhIGJsb2NrcyBhbGxvY2F0ZWQ6IDUzODU5NzUzOTg0MAog
cmVmZXJlbmNlZCAxOTA1NTc4MTA2ODgK
--------------FDD8E4153616A7790C96F612--
