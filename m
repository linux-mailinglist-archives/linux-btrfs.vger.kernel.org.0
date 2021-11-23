Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C768459A6A
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 04:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhKWDTN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 22:19:13 -0500
Received: from m1514.mail.126.com ([220.181.15.14]:53183 "EHLO
        m1514.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhKWDTN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 22:19:13 -0500
X-Greylist: delayed 1887 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Nov 2021 22:19:12 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=ISmsJ
        3qeTQGpFCYaAP0d2tZQtnxxqIrQqAmtiJjfcaA=; b=bqyGLaaPPe0EZ8ZieY7AZ
        nl7Y0JVt2kUYtwEI5R6qJBqrGNlsIure7yHILW0+/sMm1CcNXTIS453zSyWJ2RTa
        0vmYhhNpDhxyliN8xVK1P4Zj8BH4sUQAtSFk8angFTgC/yMkRVTxNyzByJu9mszL
        rEzdFAOimlITBG5SmeKyJI=
Received: from ericleaf$126.com ( [124.126.224.36] ) by ajax-webmail-wmsvr14
 (Coremail) ; Tue, 23 Nov 2021 10:42:59 +0800 (CST)
X-Originating-IP: [124.126.224.36]
Date:   Tue, 23 Nov 2021 10:42:59 +0800 (CST)
From:   x8062 <ericleaf@126.com>
To:     "Nikolay Borisov" <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re:Re: read time tree block corruption detected
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 126com
In-Reply-To: <fe1ce96b-e483-b698-f0f4-9eb8d9ad0634@suse.com>
References: <56d93523.27d4.17d461bc3c6.Coremail.ericleaf@126.com>
 <aed20fe5-4e7d-9f0f-ee39-1b584d8572f0@suse.com>
 <7f681c79.4eba.17d471d802e.Coremail.ericleaf@126.com>
 <fe1ce96b-e483-b698-f0f4-9eb8d9ad0634@suse.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <46d6bc87.14b4.17d4aacd1dc.Coremail.ericleaf@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: DsqowAC3P3Y0VZxhXIsNAA--.27099W
X-CM-SenderInfo: phuluzxhdiqiyswou0bp/1tbimhRUnVpEFJ8T4gAAsj
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

QXQgMjAyMS0xMS0yMiAxODozNjo0MSwgIk5pa29sYXkgQm9yaXNvdiIgPG5ib3Jpc292QHN1c2Uu
Y29tPiB3cm90ZToKPgo+Cj5PbiAyMi4xMS4yMSCn1C4gMTI6MDcsIHg4MDYyIHdyb3RlOgo+PiBB
dCAyMDIxLTExLTIyIDE1OjI0OjM4LCAiTmlrb2xheSBCb3Jpc292IiA8bmJvcmlzb3ZAc3VzZS5j
b20+IHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiAyMi4xMS4yMSCn1C4gNzoyNiwgeDgwNjIgd3JvdGU6
Cj4+Pj4gSGVsbG8sCj4+Pj4gIEkgZ290IHBlcmlvZGljIHdhcm5zIGluIG15IGxpbnV4IGNvbnNv
bGUuIGluIGRtZXNnIGl0IGlzIHRoZSBmb2xsb3dpbmcgcGFzdGVkIHRleHQuCj4+Pj4gQXQgaHR0
cHM6Ly9idHJmcy53aWtpLmtlcm5lbC5vcmcvaW5kZXgucGhwL1RyZWUtY2hlY2tlciBJIGxlYXJu
ZWQgaXQgbWF5IGJlIGEgZXJyb3IsIHNvIGkgc2VuZCB0aGUgbWVzc2FnZS4gSG9wZWZ1bGx5IGl0
IGNvdWxkIGhlbHAsIFRoYW5rcyBpbiBhZHZhbmNlIQo+Pj4+Cj4+Pj4gWyAgNTEzLjkwMDg1Ml0g
QlRSRlMgY3JpdGljYWwgKGRldmljZSBzZGIzKTogY29ycnVwdCBsZWFmOiByb290PTM4MSBibG9j
az03MTkyODM0ODY3MiBzbG90PTc0IGlubz0yMzk0NjM0IGZpbGVfb2Zmc2V0PTAsIGludmFsaWQg
cmFtX2J5dGVzIGZvciB1bmNvbXByZXNzZWQgaW5saW5lIGV4dGVudCwgaGF2ZSAzOTMgZXhwZWN0
IDEzMTQ2NQo+Pj4+Cj4+Pgo+Pj4KPj4+IFlvdSBoYXZlIGZhdWx0eSByYW0sIHNpbmNlIDM5MyBo
YXMgdGhlIDE3dGggYml0IHNldCB0byAwIHdoaWxzdCBoYXMgaXQKPj4+IHNldCB0byAxLiBTbyB5
b3VyIHJhbSBpcyBjbGVhcmx5IGNvcnJ1cHRpbmcgYml0cy4gSSBhZHZpc2UgeW91IHJ1biBhCj4+
PiBtZW10ZXN0IHRvb2wgYW5kIGxvb2sgZm9yIHBvc3NpYmx5IGNoYW5naW5nIHRoZSBmYXVsdHkg
cmFtIG1vZHVsZS4KPj4gCj4+IFRoYW5rIHlvdSwgY2FuJ3QgYmVsaWV2ZSB0aGUgcmFtIGlzIG5v
dCBzbyBzdGFibGUuICBJJ2xsIHJ1biBhIG1lbXRlc3QgbGF0ZXIuCj4KPkFjdHVhbGx5IGFjY29y
ZGluZyB0byB0aGUgb3V0cHV0IHRoaXMgaXMgYSByZWFkLXRpbWUgY29ycnVwdGlvbi4gVEhpcwo+
bWVhbnMgdGhlIGNvcnJ1cHRlZCBkYXRhIGhhcyBhbHJlYWR5IGJlZW4gd3JpdHRlbiB0byBkaXNr
LCBsaWtlbHkgYnkgYW4KPm9sZGVyIGtlcm5lbCB0aGF0IGRpZG4ndCBoYXZlIHRoZSB0cmVlIGNo
ZXJrIGNvZGUuIFNvIHJ1bm5pbmcgYSBtZW1jaGVjawo+aXMgc3RpbGwgdXNlZnVsIHRvIHByZXZl
bnQgZnV0dXJlIGNvcnJ1cHRpb24uCj4KPkFzIGZhciBhcyB0aGUgY29ycnVwdGVkIGZpbGVzIGdv
ZXMgLSB3ZWxsIGl0cyBkYXRhIGlzIGNvcnJ1cHRlZC4gSXQgY2FuCj50ZWNobmljYWxseSBiZSBm
aXhlZCwgYnV0IHlvdSdkIGhhdmUgdG8gZG8gaXQgeW91cnNlbGYuIE9yIGFsdGVybmF0aXZlbHkK
PmdvIGJhY2sgb24gYW4gb2xkZXIga2VybmVsIGkuZSBwcmUtIDUuMTEgYW5kIHRyeSB0byBjb3B5
IHRoYXQgcGFydGljdWxhcgo+ZmlsZSAoaW5vZGUgMjM5NDYzNCkuCj4KPj4gCkkgZmluZCBzb21l
IHByb2JsZW1zIGhlcmUuICBJIHVzZSB0aGUgY29tbWFuZCAiZmluZCAuIC1pbnVtIDIzOTQ2MzQi
IGluIHRoZSBidHJmcyByb290IGRpciwgIGJ1dCBub3RoaW5nIHByaW50ZWQuCmRvZXMgInJvb3Q9
MzgxIiBtZWFucyB0aGUgc3Vidm9sdW1lIElEPTM4MT8gYnV0IG5vdyBJIGRvbid0IGhhdmUgc3Vj
aCBzdWJ2b2x1bWUuIEkgZGVsZXRlZCBzb21lIG9mIHRoZQpzdWJ2b2x1bWVzIGEgZmV3IGRheXMg
YWdvLiB0aGlzIGlzIHRoZSBjdXJyZW50IHN1YnZvbHVtZSBsaXN0KHNvbWUgb2YgdGhlIGRpciBu
YW1lIHNob3J0ZW5lZCkKc3VkbyBidHJmcyBzdWJ2b2wgbGlzdCAuCklEIDI2MyBnZW4gMTExNzMy
IHRvcCBsZXZlbCA1IHBhdGggODAwNy9hCklEIDM1NCBnZW4gMTExNzI5IHRvcCBsZXZlbCA1IHBh
dGggODAwNy9iCklEIDYyMiBnZW4gMTExNzU3IHRvcCBsZXZlbCA1IHBhdGggZjAxNQpJRCAxMTc0
IGdlbiAxMTE3NTggdG9wIGxldmVsIDUgcGF0aCBjYwpJRCAxMzI2IGdlbiAxMTE3NTcgdG9wIGxl
dmVsIDUgcGF0aCA4MDA3L2MKSUQgMTc4MSBnZW4gMTExNzQwIHRvcCBsZXZlbCA1IHBhdGggaXAK
SUQgMTc4MiBnZW4gMTExNzU4IHRvcCBsZXZlbCA1IHBhdGggb2cKSUQgMTg1NiBnZW4gMTExNTg2
IHRvcCBsZXZlbCAxNzgyIHBhdGggb2cvT0cvREIvc2VydmVyCklEIDE4NTggZ2VuIDExMTc1NyB0
b3AgbGV2ZWwgNjIyIHBhdGggVjYvZGIKSUQgMTg3NSBnZW4gMTExNzQyIHRvcCBsZXZlbCA1IHBh
dGggc2RrCklEIDE5MTggZ2VuIDExMTc0MiB0b3AgbGV2ZWwgNSBwYXRoIDgwMTUKSUQgMTk0MiBn
ZW4gMTExNzQ1IHRvcCBsZXZlbCA1IHBhdGggaXA2CklEIDIwMDcgZ2VuIDExMTc1OCB0b3AgbGV2
ZWwgNSBwYXRoIG1uZXcKSUQgMjExNCBnZW4gMTExNzUxIHRvcCBsZXZlbCA1IHBhdGggZGQKSUQg
MjExNiBnZW4gMTExNzYwIHRvcCBsZXZlbCAyMTE3IHBhdGggZHMvdHJ1bmsvMjAyMDA2MTYKSUQg
MjExNyBnZW4gMTExNzU4IHRvcCBsZXZlbCA1IHBhdGggZHMKSUQgMjExOCBnZW4gMTExNzU4IHRv
cCBsZXZlbCAyMTE0IHBhdGggZGQvdHJ1bmsvc291cmNlY29kZQpJRCAyMTE5IGdlbiAxMTE3NTEg
dG9wIGxldmVsIDIxMTQgcGF0aCBkZC9iLzExMDMKSUQgMjEyMCBnZW4gMTExNzYxIHRvcCBsZXZl
bCA1IHBhdGggdHQK
