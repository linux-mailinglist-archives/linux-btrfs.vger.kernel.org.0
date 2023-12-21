Return-Path: <linux-btrfs+bounces-1105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED4981B945
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 15:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFCB289A3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 14:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D646D539F8;
	Thu, 21 Dec 2023 14:05:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from dragonfly.birch.relay.mailchannels.net (dragonfly.birch.relay.mailchannels.net [23.83.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060BC360B5
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Dec 2023 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 10C6E804B67;
	Thu, 21 Dec 2023 13:46:54 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id DA885804A84;
	Thu, 21 Dec 2023 13:46:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1703166409; a=rsa-sha256;
	cv=none;
	b=vR2SV30M9TJA0msqY2cmA4DDfCbMxnBDZwV+dM5EjvQrQRp1jcWyzREqDzbaRwZI073r2Z
	3JtbjtvX1sNgMTd0EuCJQK/DB9fB2/Y8eiy932l9XtHXB9+GvYiQQuMmzCcj+17IRM3Nzx
	a9r2Y8hv6sZ2KLMef9YQjbrh4t9Rq1uNhQXXz9Dp8HK+njJ2CHa9qdxjUDzkEULCnhm9CM
	4La45i2E+jv/rmxZr1/nNzD8g1/Crhlbw8xEA2mWCjkUOzka8nF7DC2LyryPHywBe8DKOR
	QG6onxlJCO0eQw4zVdErQCyrBwbJqfHnMZIPE+eMM0Reg8FTSom/n5QloJyYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1703166409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KuH6PFzaTdchlc8pqXhx9NwSaXmYut5GrEzULZ8+spI=;
	b=lnpXSYyYRHvuYbtrlYXpkNHTwk28KKsc7nsWBhXO5HosXNfnqjQEgHnUlFiuEj3PISYqfh
	iZjnciQLiYt5Oo1xg/NXWHgnVfMNISDxdaEZqb3mgg3dEP0KMmvXGvehYjLSu6iGCCKwBf
	5tnBgjXgLRO25bwrIEUx+3gSrDriyexyW2h628Dq0p2mRIQGZ1qWtK7Hz2iKM0WsfoXO0B
	7M5FLuPa30s+WM7EjMLtLhTmYQm/q38XfSeXPlU1nDu+UgEU97bxthLcwpZNCCZHvGy2N8
	b9FgPSj+fO5iEhdaZ4o6RHfG/MdAMqSaVW+YCNLvg+L5pILqHRpSvDFlHtyHSQ==
ARC-Authentication-Results: i=1;
	rspamd-856c7f878f-ds55r;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Well-Made-Skirt: 21bf68de6c506d39_1703166409810_3125382575
X-MC-Loop-Signature: 1703166409810:981188549
X-MC-Ingress-Time: 1703166409809
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.108.178.186 (trex/6.9.2);
	Thu, 21 Dec 2023 13:46:49 +0000
Received: from dhcp-138-246-3-41.dynamic.eduroam.mwn.de ([138.246.3.41]:43602 helo=[10.183.50.88])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rGJNt-0003c7-0g;
	Thu, 21 Dec 2023 13:46:47 +0000
Message-ID: <b47ed92f14edde7db5c1037a75b38652afa6c1c1.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Andrei Borzenkov <arvidjaar@gmail.com>
Cc: kreijack@inwind.it, Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	linux-btrfs@vger.kernel.org
Date: Thu, 21 Dec 2023 14:46:41 +0100
In-Reply-To: <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
	 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
	 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
	 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
	 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
	 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
	 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
	 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
	 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
	 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
	 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
	 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
	 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
	 <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
	 <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

T24gVHVlLCAyMDIzLTEyLTE5IGF0IDExOjIyICswMzAwLCBBbmRyZWkgQm9yemVua292IHdyb3Rl
Ogo+IC9kYXRhL21haW4vcHJvbWV0aGV1cy9tZXRyaWNzMi8wMUhIRkVaUEo4VFBGVllUWFYxMVI3
Wkg0WC9jaHVua3MvMDAwMAo+IDAxCj4gUHJvY2Vzc2VkIDEgZmlsZSwgMSByZWd1bGFyIGV4dGVu
dHMgKDEgcmVmcyksIDAgaW5saW5lLgo+IFR5cGXCoMKgwqDCoMKgwqAgUGVyY8KgwqDCoMKgIERp
c2sgVXNhZ2XCoMKgIFVuY29tcHJlc3NlZCBSZWZlcmVuY2VkCj4gVE9UQUzCoMKgwqDCoMKgIDEw
MCXCoMKgwqDCoMKgIDI1Nk3CoMKgwqDCoMKgwqDCoMKgIDI1Nk3CoMKgwqDCoMKgwqDCoMKgwqAg
MTVNCj4gbm9uZcKgwqDCoMKgwqDCoCAxMDAlwqDCoMKgwqDCoCAyNTZNwqDCoMKgwqDCoMKgwqDC
oCAyNTZNwqDCoMKgwqDCoMKgwqDCoMKgIDE1TQo+IAo+IEkgd291bGQgdHJ5IHRvIGZpbmQgb3V0
IHdoZXRoZXIgdGhpcyBzaW5nbGUgZXh0ZW50IGlzIHNoYXJlZCwgd2hlcmUKPiB0aGUgZGF0YSBp
cyBsb2NhdGVkIGluc2lkZSB0aGlzIGV4dGVudC4gQ291bGQgaXQgYmUgdGhhdCBmaWxlIHdhcwo+
IHRydW5jYXRlZCBvciB0aGUgaG9sZSB3YXMgcHVuY2hlZCBpbiBpdD8KCkhvdyB3b3VsZCBJIGRv
IHRoYXQ/IDotKQoKVGhhbmtzLApDaHJpcy4K


