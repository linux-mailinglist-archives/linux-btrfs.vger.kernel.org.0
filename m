Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146F77C7039
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 16:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343912AbjJLOZM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 10:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjJLOZL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 10:25:11 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FE791
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697120709; x=1728656709;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=VPF5W8YfQEYAtlgQo4D2mzy6VQjPdft9jugaeJkA6I8=;
  b=T2enpgKcCQyHlRZAlO3tepuuNJ3b7B/ffFgFrZVQzu/mNYki0bAUB0V3
   98IQW/1EBM+f/vdAEAshxuitpFaEcIb/0mpa9RZKUWl2fD7/6tAkHJTrd
   T6E0zNasSy2/HsGOQZzYaFMAV250HzWzHrVD1GMQEh/lPLVEo00jJDpVS
   E=;
X-IronPort-AV: E=Sophos;i="6.03,219,1694736000"; 
   d="scan'208";a="35402977"
Subject: RE: btrfs_extent_map memory consumption results in "Out of memory"
Thread-Topic: btrfs_extent_map memory consumption results in "Out of memory"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 14:25:07 +0000
Received: from EX19MTAUEC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com (Postfix) with ESMTPS id E67D060AC1;
        Thu, 12 Oct 2023 14:25:06 +0000 (UTC)
Received: from EX19D030UEC001.ant.amazon.com (10.252.137.253) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 12 Oct 2023 14:24:53 +0000
Received: from EX19D030UEC003.ant.amazon.com (10.252.137.182) by
 EX19D030UEC001.ant.amazon.com (10.252.137.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 12 Oct 2023 14:24:53 +0000
Received: from EX19D030UEC003.ant.amazon.com ([fe80::6222:63e7:9834:7b89]) by
 EX19D030UEC003.ant.amazon.com ([fe80::6222:63e7:9834:7b89%3]) with mapi id
 15.02.1118.037; Thu, 12 Oct 2023 14:24:53 +0000
From:   "Ospan, Abylay" <aospan@amazon.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Thread-Index: Adn7hypl09BTxineSnqUNneAxmdLqQACeriAAAcD1ZAABXSYgABUtGjQ
Date:   Thu, 12 Oct 2023 14:24:53 +0000
Message-ID: <2f2975861b0a4857ae12f114003517ec@amazon.com>
References: <13f94633dcf04d29aaf1f0a43d42c55e@amazon.com>
 <ZSVyFaWA5KZ0nTEN@debian0.Home> <ddb589008e7a4419b67134be7ae90f8b@amazon.com>
 <CAL3q7H4AEvZGNZyx8Yd4XD0AQMojQ3ifp-wmpcN9mEtxWpTOOQ@mail.gmail.com>
In-Reply-To: <CAL3q7H4AEvZGNZyx8Yd4XD0AQMojQ3ifp-wmpcN9mEtxWpTOOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.106.239.32]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGkgRmlsaXBlLA0KDQo+ID4gSSB3YXMganVzdCB3b25kZXJpbmcgYWJvdXQgImRpcmVjdCBJTyB3
cml0ZXMiLCBzbyBJIHJhbiBhIHF1aWNrIHRlc3QgYnkgZnVsbHkNCj4gcmVtb3ZpbmcgZmlvJ3Mg
Y29uZmlnIG9wdGlvbiAiZGlyZWN0PTEiIChkZWZhdWx0IHZhbHVlIGlzIGZhbHNlKS4NCj4gPiBV
bmZvcnR1bmF0ZWx5LCBJJ20gc3RpbGwgZXhwZXJpZW5jaW5nIHRoZSBzYW1lIG9vbS1raWxsOg0K
PiA+DQo+ID4gWyA0ODQzLjkzNjg4MV0NCj4gPiBvb20tDQo+IGtpbGw6Y29uc3RyYWludD1DT05T
VFJBSU5UX05PTkUsbm9kZW1hc2s9KG51bGwpLGNwdXNldD0vLG1lbXNfYWxsbw0KPiA+IHdlZD0w
LGdsb2JhbF9vb20sdGFza19tZW1jZz0vLHRhc2s9ZmlvLHBpZD02NDksdWlkPTANCj4gPiBbIDQ4
NDMuOTM5MDAxXSBPdXQgb2YgbWVtb3J5OiBLaWxsZWQgcHJvY2VzcyA2NDkgKGZpbykNCj4gPiB0
b3RhbC12bToyMTY4NjhrQiwgYW5vbi1yc3M6ODk2a0IsIGZpbGUtcnNzOjEyOGtCLCBzaG1lbS1y
c3M6MjE3NmtCLA0KPiA+IFVJRDowIHBndGFibGVzOjEwMGtCIG9vbV9zY29yZV9hMCBbIDUzMDYu
MjEwMDgyXSB0bXV4OiBzZXJ2ZXIgaW52b2tlZA0KPiBvb20ta2lsbGVyOiBnZnBfbWFzaz0weDE0
MGNjYShHRlBfSElHSFVTRVJfTU9WQUJMRXxfX0dGUF9DT01QKSwNCj4gb3JkZXI9MCwgb29tX3Nj
b3JlX2Fkaj0wIC4uLg0KPiA+IFsgNTMwNi4yNDA5NjhdIFVucmVjbGFpbWFibGUgc2xhYiBpbmZv
Og0KPiA+IFsgNTMwNi4yNDEyNzFdIE5hbWUgICAgICAgICAgICAgICAgICAgICAgVXNlZCAgICAg
ICAgICBUb3RhbA0KPiA+IFsgNTMwNi4yNDI3MDBdIGJ0cmZzX2V4dGVudF9tYXAgICAgICAgMjYw
OTNLQiAgICAgIDI2MDkzS0INCj4gPg0KPiA+IEhlcmUncyBteSB1cGRhdGVkIGZpbyBjb25maWc6
DQo+ID4gW2dsb2JhbF0NCj4gPiBuYW1lPWZpby1yYW5kLXdyaXRlDQo+ID4gZmlsZW5hbWU9Zmlv
LXJhbmQtd3JpdGUNCj4gPiBydz1yYW5kd3JpdGUNCj4gPiBicz00Sw0KPiA+IG51bWpvYnM9MQ0K
PiA+IHRpbWVfYmFzZWQNCj4gPiBydW50aW1lPTkwMDAwDQo+ID4NCj4gPiBbZmlsZTFdDQo+ID4g
c2l6ZT0zRw0KPiA+IGlvZGVwdGg9MQ0KPiA+DQo+ID4gInNsYWJ0b3AgLXMgLWEiIG91dHB1dDoN
Cj4gPiAgIE9CSlMgQUNUSVZFICBVU0UgT0JKIFNJWkUgIFNMQUJTIE9CSi9TTEFCIENBQ0hFIFNJ
WkUgTkFNRQ0KPiA+IDIwNjA4MCAyMDYwODAgMTAwJSAgICAwLjE0SyAgIDczNjAgICAgICAgMjgg
ICAgIDI5NDQwSyBidHJmc19leHRlbnRfbWFwDQo+ID4NCj4gPiBJIGFjY2VsZXJhdGVkIG15IHRl
c3RpbmcgYnkgcnVubmluZyBmaW8gdGVzdCBpbnNpZGUgYSBRRU1VIFZNIHdpdGggYSBsaW1pdGVk
DQo+IGFtb3VudCBvZiBSQU0gKDE0ME1CKToNCj4gPg0KPiA+IHFlbXUta3ZtDQo+ID4gICAta2Vy
bmVsIGJ6SW1hZ2UudjYuNiBcDQo+ID4gICAtbSAxNDBNICBcDQo+ID4gICAtZHJpdmUgZmlsZT1y
b290ZnMuYnRyZnMsZm9ybWF0PXJhdyxpZj1ub25lLGlkPWRyaXZlMA0KPiA+IC4uLg0KPiA+DQo+
ID4gSXQgYXBwZWFycyB0aGF0IHRoaXMgaXNzdWUgbWF5IG5vdCBiZSBsaW1pdGVkIHRvIGRpcmVj
dCBJTyB3cml0ZXMgYWxvbmU/DQo+IA0KPiBJbiB0aGUgYnVmZmVyZWQgSU8gY2FzZSBpdCdzIHR5
cGljYWxseSBtdWNoIGxlc3MgbGlrZWx5IHRvIGhhcHBlbi4NCj4gDQo+IFRoZSByZWFzb24gd2h5
IGl0IGhhcHBlbnMgaW4geW91ciB0ZXN0IGl0J3MgYmVjYXVzZSB0aGUgVk0gaGFzIHZlcnkgbGl0
dGxlIFJBTSwNCj4gMTQwTSwgd2hpY2ggaXMgdmVyeSB1bmxpa2VseSB0byBmaW5kIGluIHRoZSBy
ZWFsIHdvcmxkIG5vd2FkYXlzLiANCg0KSSBpbmNyZWFzZWQgdGhlIG1lbW9yeSB0byA4R0IgYW5k
IHJhbiB0aGUgdGVzdCBvdmVybmlnaHQgd2l0aG91dCBhbnkgT09NIGVycm9ycy4gR2xhZCBtZW1v
cnkgbWFuYWdlbWVudCBtZWNoYW5pc20gd29ya3MgYXMgZXhwZWN0ZWQhDQoNCj4gUGFnZXMgY2Fu
IG9ubHkNCj4gYmUgcmVsZWFzZWQgd2hlbiB0aGV5IGFyZSBub3QgZGlydHkgYW5kIG5vdCB1bmRl
ciB3cml0ZWJhY2ssIGFuZCBpbiB0aGlzIGNhc2UNCj4gdGhlcmUncyBubyBmc3luYywgc28gdGhl
IGFtb3VudCBvZiBkaXJ0eSBwYWdlcyAob3IgdW5kZXIgd3JpdGViYWNrKQ0KPiBhY2N1bXVsYXRl
cyB2ZXJ5IHF1aWNrbHkuDQo+IElmIHBhZ2VzIGNhbiBub3QgYmUgcmVsZWFzZWQsIGV4dGVudCBt
YXBzIGNhbiBub3QgYmUgcmVsZWFzZWQgZWl0aGVyLg0KPiANCj4gSWYgeW91IGFkZCAiZnN5bmM9
MSIgdG8geW91ciBmaW8gdGVzdCwgdGhpbmdzIHNob3VsZCBjaGFuZ2UgZHJhbWF0aWNhbGx5Lg0K
PiANCj4gVGhhbmtzLg0KPiANCj4gKEFuZCBidHcsIHRyeSB0byBhdm9pZCB0b3AgcG9zdGluZyBp
ZiBwb3NzaWJsZSwgYXMgdGhhdCBtYWtlcyB0aGUgdGhyZWFkIGhhcmRlcg0KPiB0byBmb2xsb3cu
KQ0KTXkgYXBvbG9naWVzIGZvciB0aGUgdG9wIHBvc3RpbmcuDQoNClRoYW5rcyBmb3IgeW91ciBo
ZWxwIQ0KDQotLQ0KQWJ5bGF5IE9zcGFuDQo=
