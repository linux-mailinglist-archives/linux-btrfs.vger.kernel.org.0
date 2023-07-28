Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165267671A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 18:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjG1QPN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 12:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjG1QPJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 12:15:09 -0400
X-Greylist: delayed 353 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Jul 2023 09:15:07 PDT
Received: from mail.mailmag.net (mail.mailmag.net [199.192.20.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7C3448E
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 09:15:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 9734015D1D0;
        Fri, 28 Jul 2023 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=dkim;
        t=1690560550; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=fmwFU7+8CUSrHW27MBm+7In9+xC8hmGq3X6Wi3Cp3XA=;
        b=mu4bnO4JdwOw56rdcSYz0MLcuk/YP3mEgqUwQWmrmu4WnBPZz/kqsppA9IMz8kh9/fcRYb
        fg+LRXtSTjnhLXattwE/4njHn+Qws4iofZQEvLiRU3LmwHi70FmNWFYR14P1J/Qy5KNbpM
        SFOjUJbBeU8XuNToRm3diP0VnUaX32miSiaK1d1rhdfc6PDYDgNz1xzV7oVXm+fQ7bsBhV
        7QJh7bGaDDbqUIhsbsVJWsyeiP5yuN8S250jf10MRa7xppisnI/yfXcWv3mtVbdMuCk/09
        +eyJJZN8ZXTaLEpUlNaTxzbn+0mSD6saALpWzYGf83SprVJk7i9Q/bB3v0/ziA==
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: base64
From:   joshua <joshua@mailmag.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Drives failures in irregular RAID1-Pool
Date:   Fri, 28 Jul 2023 08:53:40 -0700
Message-Id: <BBE0DE94-EDD2-41FF-9803-B56E95B8168B@mailmag.net>
References: <CAA3ktqmUXi3phYodmV7q8HQ4XvDvWo8q59z0UbR5TkQWcf5a=w@mail.gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
In-Reply-To: <CAA3ktqmUXi3phYodmV7q8HQ4XvDvWo8q59z0UbR5TkQWcf5a=w@mail.gmail.com>
To:     Stefan Malte Schumacher <s.schumacher@netcologne.de>
X-Last-TLS-Session-Version: None
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

WW91IHNob3VsZCBub3QgbmVlZCB0by4NCg0KQnV0IHlvdSBjYW4gdmVyaWZ5IGFsbCB5b3VyIGRh
dGEgaXMgc3RvcmVkIGFzIHJhaWQxIGJ5IHJ1bm5pbmcg4oCYYnRyZnMgZmkgdXNhZ2UvbW91bnRw
b2ludOKAmQ0KDQpJdCB3aWxsIHNob3cgd2hhdCB5b3VyIHN0b3JhZ2UgaXMgdXNlZCBmb3IgKGRh
dGEsIG1ldGFkYXRhLCBldGMpIGFzIHdlbGwgYXMgd2hhdCByYWlkIHByb2ZpbGVzIGFyZSBpbiB1
c2UgZm9yIGRpZmZlcmVudCBkYXRhLg0KDQrigJRKb3NodWEgVmlsbHdvY2sNCg0KPiBPbiBKdWwg
MjgsIDIwMjMsIGF0IDg6MjYgQU0sIFN0ZWZhbiBNYWx0ZSBTY2h1bWFjaGVyIDxzLnNjaHVtYWNo
ZXJAbmV0Y29sb2duZS5kZT4gd3JvdGU6DQo+IA0KPiDvu79UaGFua3MgZm9yIHRoZSBxdWljayBy
ZXBseS4gSXMgdGhlcmUgYW55IHdheSBmb3IgbWUgdG8gdmFsaWRhdGUgaWYgdGhlDQo+IGZpbGVz
eXN0ZW0gaGFzIHJlZHVuZGFudCBjb3BpZXMgb2YgYWxsIG15IGZpbGVzIG9uIGRpZmZlcmVudCBk
cml2ZXM/DQo+IEkgcmVhZCB0aGF0IGl0IHdhcyBzdWdnZXN0ZWQgdG8gZG8gYSBmdWxsIHJlYmFs
YW5jZSB3aGVuIGFkZGluZyBhDQo+IGRyaXZlIHRvIGEgUkFJRDUgYXJyYXkuIFNob3VsZCBJIGRv
IHRoZSBzYW1lIHdoZW4gYWRkaW5nIGEgbmV3IGRpc2sgdG8NCj4gbXkgYXJyYXk/DQo+IA0KPiBZ
b3VycyBzaW5jZXJlbHkNCj4gU3RlZmFuDQo+IA0KPj4gQW0gRnIuLCAyOC4gSnVsaSAyMDIzIHVt
IDE3OjIyIFVociBzY2hyaWViIEFuZHJlaSBCb3J6ZW5rb3YNCj4+IDxhcnZpZGphYXJAZ21haWwu
Y29tPjoNCj4+IA0KPj4+IE9uIDI4LjA3LjIwMjMgMTY6NTksIFN0ZWZhbiBNYWx0ZSBTY2h1bWFj
aGVyIHdyb3RlOg0KPj4+IEhlbGxvLA0KPj4+IA0KPj4+IEkgcmVjZW50bHkgcmVhZCBzb21ldGhp
bmcgYWJvdXQgcmFpZHogYW5kIHRydWVuYXMsIHdoaWNoIGxlZCB0byBtZQ0KPj4+IHJlYWxpemlu
ZyB0aGF0IGRlc3BpdGUgdXNpbmcgaXQgZm9yIHllYXJzIGFzIG15IG1haW4gZmlsZSBzdG9yYWdl
IEkNCj4+PiBjb3VsZG4ndCBhbnN3ZXIgdGhlIHNhbWUgcXVlc3Rpb24gcmVnYXJkaW5nIGJ0cmZz
LiBIZXJlIGl0IGNvbWVzOg0KPj4+IA0KPj4+IEkgaGF2ZSBhIHBvb2wgb2YgaGFyZGRpc2tzIG9m
IGRpZmZlcmVudCBzaXplcyB1c2luZyBSQUlEMSBmb3IgRGF0YSBhbmQNCj4+PiBNZXRhZGF0YS4g
Q2FuIHRoZSBsYXJnZXN0IGRyaXZlIGZhaWwgd2l0aG91dCBjYXVzaW5nIGFueSBkYXRhIGxvc3M/
IEkNCj4+PiBhbHdheXMgYXNzdW1lZCB0aGF0IHRoZSBkYXRhIHdvdWxkIGJlIGRpc3RyaWJ1dGVk
IGluIGEgd2F5IHRoYXQgd291bGQNCj4+PiBwcmV2ZW50IGRhdGEgbG9zcyByZWdhcmRsZXNzIG9m
IHRoZSBkcml2ZSBzaXplLCBidXQgbm93IEkgcmVhbGl6ZSBJDQo+Pj4gaGF2ZSBuZXZlciBleHBl
cmllbmNlZCB0aGlzIGJlZm9yZSBhbmQgc2hvdWxkIHByZXBhcmUgZm9yIHRoaXMNCj4+PiBzY2Vu
YXJpby4NCj4+PiANCj4+IA0KPj4gUkFJRDEgc2hvdWxkIHN0b3JlIGVhY2ggZGF0YSBjb3B5IG9u
IGEgZGlmZmVyZW50IGRyaXZlLCB3aGljaCBtZWFucyBhbGwNCj4+IGRhdGEgb24gYSBmYWlsZWQg
ZGlzayBtdXN0IGhhdmUgYW5vdGhlciBjb3B5IG9uIHNvbWUgb3RoZXIgZGlzay4NCj4+IA0KPj4+
IFRvdGFsIGRldmljZXMgNiBGUyBieXRlcyB1c2VkIDI3LjcyVGlCDQo+Pj4gZGV2aWQgICAgNyBz
aXplIDkuMTBUaUIgdXNlZCA2Ljg5VGlCIHBhdGggL2Rldi9zZGINCj4+PiBkZXZpZCAgICA4IHNp
emUgMTYuMzdUaUIgdXNlZCAxNC4xNVRpQiBwYXRoIC9kZXYvc2RmDQo+Pj4gZGV2aWQgICAgOSBz
aXplIDkuMTBUaUIgdXNlZCA2LjkwVGlCIHBhdGggL2Rldi9zZGENCj4+PiBkZXZpZCAgIDEwIHNp
emUgMTIuNzNUaUIgdXNlZCAxMC41M1RpQiBwYXRoIC9kZXYvc2RkDQo+Pj4gZGV2aWQgICAxMSBz
aXplIDEyLjczVGlCIHVzZWQgMTAuNTRUaUIgcGF0aCAvZGV2L3NkZQ0KPj4+IGRldmlkICAgMTIg
c2l6ZSA5LjEwVGlCIHVzZWQgNi45MFRpQiBwYXRoIC9kZXYvc2RjDQo+Pj4gDQo+Pj4gWW91cnMg
c2luY2VyZWx5DQo+Pj4gU3RlZmFuIFNjaHVtYWNoZXINCj4+IA0K

