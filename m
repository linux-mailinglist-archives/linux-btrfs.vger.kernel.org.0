Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF191867D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 10:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgCPJ0m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 05:26:42 -0400
Received: from m176148.mail.qiye.163.com ([59.111.176.148]:33081 "EHLO
        m176148.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbgCPJ0m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 05:26:42 -0400
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 05:26:37 EDT
Received: from vivo.com (wm-8.qy.internal [127.0.0.1])
        by m176148.mail.qiye.163.com (Hmail) with ESMTP id A20D81A3EA2;
        Mon, 16 Mar 2020 17:17:36 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AOAAuQCVCHmM4WW4PQrFj4rw.3.1584350256616.Hmail.wei.zheng@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Allison Randal <allison@lohutok.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        Enrico Weigelt <info@metux.net>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel@vivo.com, wenhu.wang@vivo.com
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MixSRVNFTkRdIGJ0cmZzOiBmaXggdGhlIGR1cGxpY2F0ZWQgZGVmaW5pdGlvbiBvZiAnaW5vZGVfaXRlbV9lcnIn?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.227
In-Reply-To: <20200316082021.GA3146292@kroah.com>
MIME-Version: 1.0
Received: from wei.zheng@vivo.com( [58.251.74.227) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 16 Mar 2020 17:17:36 +0800 (GMT+08:00)
From:   =?UTF-8?B?6YOR5Lyf?= <wei.zheng@vivo.com>
Date:   Mon, 16 Mar 2020 17:17:36 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VCSEJLS0tKSUJNQkJMSllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhNTEpITkpMTExPN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6NDo6Dio4LTgzFjZPLCxPKyoJPRFPCQxVSFVKTkNPSE5LSU5NTE1JVTMWGhIXVQweElUBEx4V
        HDsNEg0UVRgUFkVZV1kSC1lBWU5DVUlOSlVMT1VJSUxZV1kIAVlBT0JKTDcG
X-HM-Tid: 0a70e2a25e2a9394kuwsa20d81a3ea2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

RnJvbTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KRGF0
ZTogMjAyMC0wMy0xNiAxNjoyMDoyMQpUbzogIFpoZW5nIFdlaSA8d2VpLnpoZW5nQHZpdm8uY29t
PgpDYzogIENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+LFdpbGwgRGVh
Y29uIDx3aWxsQGtlcm5lbC5vcmc+LENocmlzIE1hc29uIDxjbG1AZmIuY29tPixKb3NlZiBCYWNp
ayA8am9zZWZAdG94aWNwYW5kYS5jb20+LERhdmlkIFN0ZXJiYSA8ZHN0ZXJiYUBzdXNlLmNvbT4s
QWxsaXNvbiBSYW5kYWwgPGFsbGlzb25AbG9odXRvay5uZXQ+LEhhbmp1biBHdW8gPGd1b2hhbmp1
bkBodWF3ZWkuY29tPixFbnJpY28gV2VpZ2VsdCA8aW5mb0BtZXR1eC5uZXQ+LFl1bmZlbmcgWWUg
PHlleXVuZmVuZ0BodWF3ZWkuY29tPixUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5k
ZT4sbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnLGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcsbGludXgtYnRyZnNAdmdlci5rZXJuZWwub3JnLGtlcm5lbEB2aXZvLmNvbSx3
ZW5odS53YW5nQHZpdm8uY29tClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIsUkVTRU5EXSBidHJmczog
Zml4IHRoZSBkdXBsaWNhdGVkIGRlZmluaXRpb24gb2YgJ2lub2RlX2l0ZW1fZXJyJz5PbiBNb24s
IE1hciAxNiwgMjAyMCBhdCAxMTo0NTo1N0FNICswODAwLCBaaGVuZyBXZWkgd3JvdGU6Cj4+IHJl
bW92ZSB0aGUgZHVwbGljYXRlZCBkZWZpbml0aW9uIG9mICdpbm9kZV9pdGVtX2VycicKPj4gaW4g
dGhlIGZpbGUgdHJlZS1jaGVja2VyLmMKPj4gCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW5nIFdlaSA8
d2VpLnpoZW5nQHZpdm8uY29tPgo+PiAtLS0KPj4gCj4+IGNoYW5nZWxvZwo+PiB2MSAtPiB2Mgo+
PiAgLSByZXNlbmQgZm9yIHRoZSBmYWlsdXJlIG9mIGRlbGl2ZXJ5IHRvIHNvbWUgcmVjaXBpZW50
cy4KPj4gCj4+ICBmcy9idHJmcy90cmVlLWNoZWNrZXIuYyB8IDQgLS0tLQo+PiAgMSBmaWxlIGNo
YW5nZWQsIDQgZGVsZXRpb25zKC0pCj4KPllvdXIgY2hvaWNlIG9mIHBlb3BsZSB0byBzZW5kIHRo
aXMgcGF0Y2ggdG8gaXMgdmVyeSBvZGQ6Cj4KPiQgLi9zY3JpcHRzL2dldF9tYWludGFpbmVyLnBs
IC0tZmlsZSBmcy9idHJmcy90cmVlLWNoZWNrZXIuYwo+Q2hyaXMgTWFzb24gPGNsbUBmYi5jb20+
IChtYWludGFpbmVyOkJUUkZTIEZJTEUgU1lTVEVNKQo+Sm9zZWYgQmFjaWsgPGpvc2VmQHRveGlj
cGFuZGEuY29tPiAobWFpbnRhaW5lcjpCVFJGUyBGSUxFIFNZU1RFTSkKPkRhdmlkIFN0ZXJiYSA8
ZHN0ZXJiYUBzdXNlLmNvbT4gKG1haW50YWluZXI6QlRSRlMgRklMRSBTWVNURU0pCj5saW51eC1i
dHJmc0B2Z2VyLmtlcm5lbC5vcmcgKG9wZW4gbGlzdDpCVFJGUyBGSUxFIFNZU1RFTSkKPmxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgKG9wZW4gbGlzdCkKPgpzbyBzb3JyeSBmb3IgdGhpcywK
YXMgYSBuZXcgc3VibWl0dGVyLCBJIHVzZWQgJ3NjcmlwdHMvZ2V0X21haW50YWluZXIucGwgbXkg
cGF0Y2gnIGNvbW1hbmQgdG8gZ2V0IHRoZSBtYWlsaW5nIGxpc3QuCkknbGwgcGF5IG1vcmUgYXR0
ZW50aW9uIG5leHQgdGltZS4KClRoYW5rcywKWmhlbmcgV2VpCj4KPlBsZWFzZSBiZSBtb3JlIG1p
bmRmdWwuCj4KPnRoYW5rcywKPgo+Z3JlZyBrLWgKDQoNCg==
