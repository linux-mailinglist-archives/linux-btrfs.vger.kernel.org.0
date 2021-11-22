Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13701458C14
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 11:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhKVKLo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 05:11:44 -0500
Received: from m1533.mail.126.com ([220.181.15.33]:13311 "EHLO
        m1533.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhKVKLn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 05:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=zXVXP
        71VjcPmloraMCgh4AehQfUXKRMwzVI30sRwh30=; b=Ouv4lM+T8kGiOr9zKQkS1
        DN62ycm8BxJBRN5/0XDpsZ8utg5ZV/B2p54m1nhkdrjoP7TU3V/gjmyhM06nGlUO
        +CBkH9QwegS0F9IvSyD4gKsUnzEh0ehHalhJD7f/XpNZep1MqK+m17Wk76/4z3AV
        f+oTfaEFqf5DZjMFS9zPkE=
Received: from ericleaf$126.com ( [124.126.224.36] ) by ajax-webmail-wmsvr33
 (Coremail) ; Mon, 22 Nov 2021 18:07:35 +0800 (CST)
X-Originating-IP: [124.126.224.36]
Date:   Mon, 22 Nov 2021 18:07:35 +0800 (CST)
From:   x8062 <ericleaf@126.com>
To:     "Nikolay Borisov" <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re:Re: read time tree block corruption detected
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 126com
In-Reply-To: <aed20fe5-4e7d-9f0f-ee39-1b584d8572f0@suse.com>
References: <56d93523.27d4.17d461bc3c6.Coremail.ericleaf@126.com>
 <aed20fe5-4e7d-9f0f-ee39-1b584d8572f0@suse.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <7f681c79.4eba.17d471d802e.Coremail.ericleaf@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: IcqowAAXgRjna5th+4+dAQ--.34063W
X-CM-SenderInfo: phuluzxhdiqiyswou0bp/1tbirwdTnVpECgtrewAAsp
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

QXQgMjAyMS0xMS0yMiAxNToyNDozOCwgIk5pa29sYXkgQm9yaXNvdiIgPG5ib3Jpc292QHN1c2Uu
Y29tPiB3cm90ZToKPgo+Cj5PbiAyMi4xMS4yMSCn1C4gNzoyNiwgeDgwNjIgd3JvdGU6Cj4+IEhl
bGxvLAo+PiAgSSBnb3QgcGVyaW9kaWMgd2FybnMgaW4gbXkgbGludXggY29uc29sZS4gaW4gZG1l
c2cgaXQgaXMgdGhlIGZvbGxvd2luZyBwYXN0ZWQgdGV4dC4KPj4gQXQgaHR0cHM6Ly9idHJmcy53
aWtpLmtlcm5lbC5vcmcvaW5kZXgucGhwL1RyZWUtY2hlY2tlciBJIGxlYXJuZWQgaXQgbWF5IGJl
IGEgZXJyb3IsIHNvIGkgc2VuZCB0aGUgbWVzc2FnZS4gSG9wZWZ1bGx5IGl0IGNvdWxkIGhlbHAs
IFRoYW5rcyBpbiBhZHZhbmNlIQo+PiAKPj4gWyAgNTEzLjkwMDg1Ml0gQlRSRlMgY3JpdGljYWwg
KGRldmljZSBzZGIzKTogY29ycnVwdCBsZWFmOiByb290PTM4MSBibG9jaz03MTkyODM0ODY3MiBz
bG90PTc0IGlubz0yMzk0NjM0IGZpbGVfb2Zmc2V0PTAsIGludmFsaWQgcmFtX2J5dGVzIGZvciB1
bmNvbXByZXNzZWQgaW5saW5lIGV4dGVudCwgaGF2ZSAzOTMgZXhwZWN0IDEzMTQ2NQo+PiAKPgo+
Cj5Zb3UgaGF2ZSBmYXVsdHkgcmFtLCBzaW5jZSAzOTMgaGFzIHRoZSAxN3RoIGJpdCBzZXQgdG8g
MCB3aGlsc3QgaGFzIGl0Cj5zZXQgdG8gMS4gU28geW91ciByYW0gaXMgY2xlYXJseSBjb3JydXB0
aW5nIGJpdHMuIEkgYWR2aXNlIHlvdSBydW4gYQo+bWVtdGVzdCB0b29sIGFuZCBsb29rIGZvciBw
b3NzaWJseSBjaGFuZ2luZyB0aGUgZmF1bHR5IHJhbSBtb2R1bGUuCgpUaGFuayB5b3UsIGNhbid0
IGJlbGlldmUgdGhlIHJhbSBpcyBub3Qgc28gc3RhYmxlLiAgSSdsbCBydW4gYSBtZW10ZXN0IGxh
dGVyLg==
