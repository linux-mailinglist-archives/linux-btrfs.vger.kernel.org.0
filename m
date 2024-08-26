Return-Path: <linux-btrfs+bounces-7488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4758F95EE03
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 12:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0341B284BB0
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B512145A01;
	Mon, 26 Aug 2024 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="YQ8sTJNf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E1712DD90
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666664; cv=none; b=dFq2YiTudnc9kbqtvsSJo505zbG/ph153q/u2vUk0HhdpUoq3myd6dApBM30rbzSxuoYKP7H4avvFl3KRpLilmE5aTsVp/lrd8zLrYMcvoyd2tx4k2r2++zCfznPknL5bkF4xfMRyuWsqGntSbm+6qw9gX7cH11SROJSxnvwrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666664; c=relaxed/simple;
	bh=qMM457lu3I8jbZYpOeaEnC6DUK1H/JeK/r5JmqwT6ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uy8etK1INUibVCMTmNjVY1m03A3XuKE9zuBBVuqcMClSheq2ezSuntvA3WdftqrzTtVkkqOywTSz2nyeso0tAAGN0Z0X2w29m+S15AuAj0S/OP/XS1ZpoWFFJLdnzVeJceKBC7DK0kpS4j9wWipCEllSZPpCfhPNMYPnowJTEKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=YQ8sTJNf; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1724666654;
	bh=qMM457lu3I8jbZYpOeaEnC6DUK1H/JeK/r5JmqwT6ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=YQ8sTJNfUqT1EGPCHSfMojPbHW7ytT6md9lfdUsRGfZkV3gr67Q8EXodkxC/cWA5c
	 EZ5kQKexQXI43apHQ1MSz7gWG6WrwgbdLkISMq8OViHQ0cYWbtbyBWzmDfimAu10Rv
	 6QVl5OaGgH0UMD4JVP3gMDzfeX920yaJWwAUfAD8=
X-QQ-mid: bizesmtpip3t1724666653tidjlmg
X-QQ-Originating-IP: DtLXirwlpGDA6hokLE22MI6Cqh833s+WDI2NzTM70RY=
Received: from [IPV6:2408:8215:5910:5dc0:166b: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 26 Aug 2024 18:04:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8172147434646186442
Message-ID: <1F186795D5BE22A6+fe73060c-a6b9-4b31-a792-af963d06c157@bupt.moe>
Date: Mon, 26 Aug 2024 18:04:12 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can't set RAID10 on zoned device using experimental build
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <65B7F79F09D5083C+d0bb90c4-ba72-4b8e-8275-9ee8bfdbd3dd@bupt.moe>
 <xi6vsetz4ymtdyfw564e7gkdpdsqqe6xxvn2rujuchhw423vz5@fomt4llvviq5>
Content-Language: en-US
From: Yuwei Han <hrx@bupt.moe>
In-Reply-To: <xi6vsetz4ymtdyfw564e7gkdpdsqqe6xxvn2rujuchhw423vz5@fomt4llvviq5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

DQoNCuWcqCAyMDI0LzgvMjYgMTM6MjAsIE5hb2hpcm8gQW90YSDlhpnpgZM6DQo+IE9uIFN1
biwgQXVnIDI1LCAyMDI0IGF0IDEwOjU5OjQ5QU0gR01ULCBZdXdlaSBIYW4gd3JvdGU6DQo+
PiBIaSwNCj4+IEkgYW0gdXNpbmcgYnRyZnMtcHJvZ3MgZXhwZXJpbWVudGFsIGJ1aWxkIHRv
IGNyZWF0ZSBSQUlEMTAgdm9sdW1lIG9uIHpvbmVkDQo+PiBkZXZpY2UuIEJ1dCBpdCBkaWRu
J3Qgc3VjY2VlZC4NCj4+DQo+PiAjIC4vYnRyZnMgdmVyc2lvbg0KPj4gYnRyZnMtcHJvZ3Mg
djYuMTAuMQ0KPj4gK0VYUEVSSU1FTlRBTCAtSU5KRUNUIC1TVEFUSUMgK0xaTyArWlNURCAr
VURFViArRlNWRVJJVFkgK1pPTkVEDQo+PiBDUllQVE89YnVpbHRpbg0KPj4NCj4+ICMgLi9t
a2ZzLmJ0cmZzIC1mIC1PIGJndCxyc3QgLW1yYWlkMTAgLWRyYWlkMTAgL2Rldi9zZGEgL2Rl
di9zZGIgL2Rldi9zZGMNCj4+IC9kZXYvc2RkDQo+PiBidHJmcy1wcm9ncyB2Ni4xMC4xDQo+
PiBTZWUgaHR0cHM6Ly9idHJmcy5yZWFkdGhlZG9jcy5pbyBmb3IgbW9yZSBpbmZvcm1hdGlv
bi4NCj4+DQo+PiBab25lZDogL2Rldi9zZGE6IGhvc3QtbWFuYWdlZCBkZXZpY2UgZGV0ZWN0
ZWQsIHNldHRpbmcgem9uZWQgZmVhdHVyZQ0KPj4gUmVzZXR0aW5nIGRldmljZSB6b25lcyAv
ZGV2L3NkYSAoNTIxNTYgem9uZXMpIC4uLg0KPj4gUmVzZXR0aW5nIGRldmljZSB6b25lcyAv
ZGV2L3NkYiAoNTIxNTYgem9uZXMpIC4uLg0KPj4gUmVzZXR0aW5nIGRldmljZSB6b25lcyAv
ZGV2L3NkYyAoNTIxNTYgem9uZXMpIC4uLg0KPj4gUmVzZXR0aW5nIGRldmljZSB6b25lcyAv
ZGV2L3NkZCAoNTIxNTYgem9uZXMpIC4uLg0KPj4gRVJST1I6IHpvbmVkOiBmYWlsZWQgdG8g
cmVzZXQgZGV2aWNlICcvZGV2L3NkZCcgem9uZXM6IFJlbW90ZSBJL08gZXJyb3INCj4+IEVS
Uk9SOiB6b25lZDogZmFpbGVkIHRvIHJlc2V0IGRldmljZSAnL2Rldi9zZGInIHpvbmVzOiBS
ZW1vdGUgSS9PIGVycm9yDQo+PiBFUlJPUjogem9uZWQ6IGZhaWxlZCB0byByZXNldCBkZXZp
Y2UgJy9kZXYvc2RjJyB6b25lczogUmVtb3RlIEkvTyBlcnJvcg0KPj4gRVJST1I6IHpvbmVk
OiBmYWlsZWQgdG8gcmVzZXQgZGV2aWNlICcvZGV2L3NkYScgem9uZXM6IFJlbW90ZSBJL08g
ZXJyb3INCj4+IEVSUk9SOiB1bmFibGUgcHJlcGFyZSBkZXZpY2U6IC9kZXYvc2RhDQo+Pg0K
Pj4gcmVsYXRlZCBkbWVzZzoNCj4+IFsgNDc5LjcyOTI4MV0gc2QgMDowOjI6MDogW3NkY10g
dGFnIzk1MyBGQUlMRUQgUmVzdWx0OiBob3N0Ynl0ZT1ESURfT0sNCj4+IGRyaXZlcmJ5dGU9
RFJJVkVSX09LIGNtZF9hZ2U9MHMNCj4+IFsgIDQ3OS43Mjk5MzBdIHNkIDA6MDoxOjA6IFtz
ZGJdIHRhZyMxODQgRkFJTEVEIFJlc3VsdDogaG9zdGJ5dGU9RElEX09LDQo+PiBkcml2ZXJi
eXRlPURSSVZFUl9PSyBjbWRfYWdlPTBzDQo+PiBbICA0NzkuNzI5OTQ0XSBzZCAwOjA6Mzow
OiBbc2RkXSB0YWcjMTIgRkFJTEVEIFJlc3VsdDogaG9zdGJ5dGU9RElEX09LDQo+PiBkcml2
ZXJieXRlPURSSVZFUl9PSyBjbWRfYWdlPTBzDQo+PiBbICA0NzkuNzI5OTQ5XSBzZCAwOjA6
MzowOiBbc2RkXSB0YWcjMTIgU2Vuc2UgS2V5IDogSWxsZWdhbCBSZXF1ZXN0DQo+PiBbY3Vy
cmVudF0NCj4+IFsgIDQ3OS43Mjk5NTFdIHNkIDA6MDozOjA6IFtzZGRdIHRhZyMxMiBBZGQu
IFNlbnNlOiBJbnZhbGlkIGZpZWxkIGluIGNkYg0KPj4gWyAgNDc5LjcyOTk1NF0gc2QgMDow
OjM6MDogW3NkZF0gdGFnIzEyIENEQjogV3JpdGUgc2FtZSgxNikgOTMgMDggMDAgMDAgMDAN
Cj4+IDAwIDAwIDAwIDAwIDAwIDAwIDAxIDAwIDAwIDAwIDAwDQo+PiBbICA0NzkuNzI5OTU2
XSBjcml0aWNhbCB0YXJnZXQgZXJyb3IsIGRldiBzZGQsIHNlY3RvciAwIG9wIDB4MzooRElT
Q0FSRCkNCj4+IGZsYWdzIDB4ODAwIHBoeXNfc2VnIDEgcHJpbyBjbGFzcyAwDQo+PiBbICA0
NzkuNzI5OTYwXSBzZCAwOjA6MDowOiBbc2RhXSB0YWcjNTk3IEZBSUxFRCBSZXN1bHQ6IGhv
c3RieXRlPURJRF9PSw0KPj4gZHJpdmVyYnl0ZT1EUklWRVJfT0sgY21kX2FnZT0wcw0KPj4g
WyAgNDc5LjcyOTk2M10gc2QgMDowOjA6MDogW3NkYV0gdGFnIzU5NyBTZW5zZSBLZXkgOiBJ
bGxlZ2FsIFJlcXVlc3QNCj4+IFtjdXJyZW50XQ0KPj4gWyAgNDc5LjcyOTk2Nl0gc2QgMDow
OjA6MDogW3NkYV0gdGFnIzU5NyBBZGQuIFNlbnNlOiBJbnZhbGlkIGZpZWxkIGluIGNkYg0K
Pj4gWyAgNDc5LjcyOTk2OF0gc2QgMDowOjA6MDogW3NkYV0gdGFnIzU5NyBDREI6IFdyaXRl
IHNhbWUoMTYpIDkzIDA4IDAwIDAwIDAwDQo+PiAwMCAwMCAwMCAwMCAwMCAwMCAwMSAwMCAw
MCAwMCAwMA0KPj4gWyAgNDc5LjcyOTk3MF0gY3JpdGljYWwgdGFyZ2V0IGVycm9yLCBkZXYg
c2RhLCBzZWN0b3IgMCBvcCAweDM6KERJU0NBUkQpDQo+PiBmbGFncyAweDgwMCBwaHlzX3Nl
ZyAxIHByaW8gY2xhc3MgMA0KPj4gWyAgNDc5LjczODM2M10gc2QgMDowOjI6MDogW3NkY10g
dGFnIzk1MyBTZW5zZSBLZXkgOiBJbGxlZ2FsIFJlcXVlc3QNCj4+IFtjdXJyZW50XQ0KPj4g
WyAgNDc5Ljc0NzQzOF0gc2QgMDowOjE6MDogW3NkYl0gdGFnIzE4NCBTZW5zZSBLZXkgOiBJ
bGxlZ2FsIFJlcXVlc3QNCj4+IFtjdXJyZW50XQ0KPj4gWyAgNDc5Ljc1NjQyNV0gc2QgMDow
OjI6MDogW3NkY10gdGFnIzk1MyBBZGQuIFNlbnNlOiBJbnZhbGlkIGZpZWxkIGluIGNkYg0K
Pj4gWyAgNDc5Ljc2MzMzOF0gc2QgMDowOjE6MDogW3NkYl0gdGFnIzE4NCBBZGQuIFNlbnNl
OiBJbnZhbGlkIGZpZWxkIGluIGNkYg0KPj4gWyAgNDc5Ljc2OTczM10gc2QgMDowOjI6MDog
W3NkY10gdGFnIzk1MyBDREI6IFdyaXRlIHNhbWUoMTYpIDkzIDA4IDAwIDAwIDAwDQo+PiAw
MCAwMCAwMCAwMCAwMCAwMCAwMSAwMCAwMCAwMCAwMA0KPj4gWyAgNDc5Ljc3OTE1Ml0gc2Qg
MDowOjE6MDogW3NkYl0gdGFnIzE4NCBDREI6IFdyaXRlIHNhbWUoMTYpIDkzIDA4IDAwIDAw
IDAwDQo+PiAwMCAwMCAwMCAwMCAwMCAwMCAwMSAwMCAwMCAwMCAwMA0KPj4gWyAgNDc5Ljc4
ODY1Nl0gY3JpdGljYWwgdGFyZ2V0IGVycm9yLCBkZXYgc2RjLCBzZWN0b3IgMCBvcCAweDM6
KERJU0NBUkQpDQo+PiBmbGFncyAweDgwMCBwaHlzX3NlZyAxIHByaW8gY2xhc3MgMA0KPj4g
WyAgNDc5Ljc5NzczMF0gY3JpdGljYWwgdGFyZ2V0IGVycm9yLCBkZXYgc2RiLCBzZWN0b3Ig
MCBvcCAweDM6KERJU0NBUkQpDQo+PiBmbGFncyAweDgwMCBwaHlzX3NlZyAxIHByaW8gY2xh
c3MgMA0KPj4NCj4+IGRyaXZlIGluZm86IFdEQyBIQzYyMCAoSFNINzIxNDE0QUxONk0wKQ0K
Pj4NCj4+DQo+IA0KPiBBcmUgeW91IHVzaW5nIGEgLXJjIGtlcm5lbD8gVGhpcyBsb29rcyBz
aW1pbGFyIHRvIGFuIGlzc3VlIHJlcG9ydGVkIGhlcmUuDQpZZXMuIEkgYW0gdXNpbmcgNi4x
MS1yYzQga2VybmVsLiBTaG91bGQgSSBjaGFuZ2UgdG8gcmM1Pw0KDQpIQU4gWXV3ZWkNCj4g
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXNjc2kvWnJvZzREWVhyaXJoSkU3
UEBkZWJpYW4ubG9jYWwvDQo=


