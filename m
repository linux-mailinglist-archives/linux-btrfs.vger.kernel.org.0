Return-Path: <linux-btrfs+bounces-2834-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519BD868E9A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 12:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07ECB282B84
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 11:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73F8139591;
	Tue, 27 Feb 2024 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PWsFQdlR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dFeSM0Qz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D372D12A14B;
	Tue, 27 Feb 2024 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032694; cv=fail; b=sbVuIXPoYbOvyc7uOgaaOpn1oOGijrRA2vb/SRT7ZV8uuHkzUUhks7nua5MPPyvfEhNvY3dUvOy3+to+eSpt+hb1Lmlv5qBTUBMM5ml0cjFLUSBoWFEIfq1qGvmhpBEujIEPrXczAJjSXZ93Q0XabAo6b7mJ4EKj+/4kvhYX/sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032694; c=relaxed/simple;
	bh=ly5u0Rk9J0aIbU+CYtdHvNhgUoqXorqXk9IEOWagbkA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RYmqgUmlhYa7CuC7c1ram6e/6F2Il2n+RaPnOSw3hI1sDmQkBBzVY6Uw8wNJq9iK/OKK2FFQSHTVniQuU7IYnkFTQmiEYZ5rMNhhMUn5UT/6AhFG7A+HncKbkU1mHD8n9UqRzZVGqb1Y3UiHhbs794zDiMBBLeec1eOxBtUTRF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PWsFQdlR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=dFeSM0Qz; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709032692; x=1740568692;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ly5u0Rk9J0aIbU+CYtdHvNhgUoqXorqXk9IEOWagbkA=;
  b=PWsFQdlR/TBJ9dLavu9DAKC1D07l4AENwMprUWilG+QluxlMOFJlfgr9
   C0IRpEByt4I1V47sLgMjf08xeQxEwJ6BuFo8aBNHADySlOOdBqn6WAWhc
   kDp/dvTtdYo8pUvTFCscOQeEBejP3Pn53hHQEta3+T6sJ22Mhts7GEOAM
   PvkCzFwVRMikKU7BaHGB+h/wUeBc6/sW4wCPf+jAx4GQuoChJr00S3O6v
   DBVPtpZuKRdW2G0pzvhj97kg6Q0TId3m9S/JEi+XmBRCc4CUR0bhjird+
   pxwHHLyPPb7p0FfmtcSPxx6yD79SjQXHeyIk04G5Br4nUJ6VmUc9Q5K61
   A==;
X-CSE-ConnectionGUID: V9rkOa59RpWEasua0TVWFw==
X-CSE-MsgGUID: XfghdneQT7Gktq6aUzzjZA==
X-IronPort-AV: E=Sophos;i="6.06,187,1705334400"; 
   d="scan'208";a="10154597"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2024 19:18:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLlTyuEI34UChX2UbbPSU14+Z+yBABsM/5Tf7F+EJWDL2+JasKCXhJNjg0YuXk5FN/z9sC0NKzpW7vuiDQPcJ6sMT31n5cBzpttG51YJLLx/LnfQzza+hpUiuW3OrwKA0PpxWzv11UYf3pfK1jBwvXpaRghFEE1GaGdzBYlODndrxil3N4EHBA3iKooRfXN+fiVAl1APGZfJR8o2Tu6Lgfc/KUeqT1qsIi+1pZ24tPX4Zz9Tmb4LBbgxUR2oFu2AfkOFslCM4mZZrROdoiC0Z68RUaXIdw3t7itHpGTA0Dbooks2oYWULNY7LoPc2gqIN+8ZC6yUMGRlEj/NPVWUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly5u0Rk9J0aIbU+CYtdHvNhgUoqXorqXk9IEOWagbkA=;
 b=WKYt8R5bpJoX99j56g50Gc+aDh+EUI57aCp2cDYScD/erLTPohIwNY+PjgTL+mAiOyA0Ig20G1w3aRx+wqsIxSS6uJNzDKGJe/+Gso7JUjLi9efUJiTXG+NcYS7P9OD5GJ9QO0zqMQIA42yoRtTQdd27tDI8v/uxyepGLS+br21h19igQVHKRipIhawhIFYmlzwEVu3Av4A2lKMRSPY9dJ+ISrNczKH8zOygoH1k1AXpjySlwFcFHusNSl2vAs52ElR3xYXU1C25/f0hV5Z2AsFnaY92L3g1dBmM7tC98d4xDtqoJve4lP1rrgxE8gXES7Keo6l5v608OdRRPxoavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly5u0Rk9J0aIbU+CYtdHvNhgUoqXorqXk9IEOWagbkA=;
 b=dFeSM0Qz+DyXtu2ebZN8pHSgd0iGkYocinr8CiNAxafQhioNbDWQdwJufTlZebhgMTgmu6CEQ+VsX6UXe/fOE+3pyS3OY525IyymO6bJLxdFLFz4IR9WhmAmL0xnWt+aQO+ffV9r4u2e0dAk+n6C3MI0UiMXLVxV9DUvXlhlkEM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7661.namprd04.prod.outlook.com (2603:10b6:a03:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 11:18:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%6]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 11:18:03 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Anand Jain <anand.jain@oracle.com>
CC: Zorro Lang <zlang@redhat.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, "fdmanana@suse.com" <fdmanana@suse.com>
Subject: Re: [PATCH v3 2/3] filter.btrfs: add filter for btrfs device add
Thread-Topic: [PATCH v3 2/3] filter.btrfs: add filter for btrfs device add
Thread-Index: AQHaYAS407+8S9q4l0O65QPZ8BK6HrEc7xCAgAEuJwA=
Date: Tue, 27 Feb 2024 11:18:03 +0000
Message-ID: <e6e04661-eb57-4239-8246-6d4bfbb813b4@wdc.com>
References: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
 <20240215-balance-fix-v3-2-79df5d5a940f@wdc.com>
 <43fbb951-664a-4224-95d0-a8011495d698@oracle.com>
In-Reply-To: <43fbb951-664a-4224-95d0-a8011495d698@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7661:EE_
x-ms-office365-filtering-correlation-id: 3939b9af-bf1d-4bdb-a4c1-08dc3785c3a0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 m90HeWpqgwieJpBOT4GUW/Po/LkwcPM74cnVlQLNH9KDMmoofkQCLu5Lk5+7UqEnqr78lCORZzfTtUzVFjrqhwZjygb6fkNlzPpHI56LiNHpKmfDsxthPNXckdr+QhICx8Q0BgP/7b61fS668qodMXh6L9DzCjqVD8o0MeEoEjpT2ZMtuiziQPhQZfLVKn+Xpjze7lO7W5XMxkr9lNLkUnTV7Qls9pM/j9e2exAHpqCQ6x2LUAojIZOpQtH6lMHIfCW4XtQwDfTrFeADCIZ+MewJyNajrEl3DfR5SCbezN14hWxNKbJ6+XHoz1V/TGfz34qJuXbC67Uj+k6PI4V83DVAxybk41YRcMLV2qlb2rcEzM5p8duicSZNDVDdqiZRwOxaNaWoGlZaTy+gxgcsnr75KgG73pb69BmAXUcrBAw9+SglFSkw0U6jonIM+9yvRklOVWz3InsYDrzftP9cToCaXum7+sxLR8EZKPK/3o3aXs8rqIHLXxjq1aRDoSRRAkRDjOyB0kkPergwZege4aAKxuCUnRaW5cFsMX2VJYOdGL4SYb9j3bKJonsv0w7WhZdTgRHWkdPdyaGPrQyl5QvhDp5cCrpGK9qglfFK1wv3haMS64Gh4KHn0jSYN260+vsOUm3GoNmR8leD/dEdyMmk+l6kUqQqcNNFTOOdnKyUwFY/9Sn0AB/+oxI4+l9UfbHgppINzlyPlJ0jGSZ6kg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmF5ZUYyUDltRUhRMEQ1QzJKWkJYYVVRNE9MUFRHZ1g0bDFQNVVRQ05WQUZX?=
 =?utf-8?B?cXhLUkg3RFRqN3NWZnVLUllCVngrYkFvbmxrV2RsTlNWMG1qNTNUMHE2MGtu?=
 =?utf-8?B?WTcvWUVxUFpNU0NkNHdyM09JNENMamM1TDNqTUdwdW84dzZHa0NtTHBSMGFQ?=
 =?utf-8?B?em5QbUJ1ajVHTTYwRDZBUkY2WHBiTWFNd0Zvd1ZnQm53TzBDczdiS1lGN1pT?=
 =?utf-8?B?MzBOSnk4QklQTzZkdE5TTU5YZ1UxNWF6ZTJQcis3Zzl5NTFtZUluN0xtOVNp?=
 =?utf-8?B?UnFFYzJRd0w5OFd3VzZSRWk4N1pCcHlUT0l2SjFzN21GeThWOTJzQjNvdXZX?=
 =?utf-8?B?bVpJUEY1blNTeWYvWkJXcm12WUZYRno2OTBDQVZDMG1sSkZwZUZ4M2diWUpD?=
 =?utf-8?B?TGRKRFVkZGliL3dmQUlrLzhCRUNrcFF5MlRFWTcxdDBvWjJHankvdGNqS1Jo?=
 =?utf-8?B?QlpvWmtpbEtuT2ZMcHNmd01ZRWlvWEIvSW1ydnVoSjNyRFM1M0p3V2h5WjQv?=
 =?utf-8?B?aG91QzhGbW1pVjJCblljNTI2S0hvREZVWFZmSDV6eTdlRkdtSmtxc0p4YXlQ?=
 =?utf-8?B?Q2N4R2JmMUtqNVhwYWFXK2JqUDJkdjFGQmQ5Q0VYMVdWYlI5Vzg0bURydjlM?=
 =?utf-8?B?c0x6cTFFWVVWRGpjeGxNYitpSlhBdW1TN0F0amYxZ1NWczBqV3ZIZWxCZDV2?=
 =?utf-8?B?OWFzK1JVak5RVVIvUDNTUnNGSUE1NDhSc2lSTzJDSVMxUSszQmpxemxhZDRW?=
 =?utf-8?B?VWxFOXhrTGhOOVZlRU12eVRIODhvUEQ2NndjaG0yTStOZ01CSGFCck44czNM?=
 =?utf-8?B?TUVVT0M4SUZPaURvOUtXaUhTWmwxOGFtQWR3R0l3cFlTV3hoQXVFV21wKy9M?=
 =?utf-8?B?SGJqcWRLdC81amMzZWs3K1ppU3JJL3NIZ3ptKzdrRG5FWlF0ZW5nTWNXK1dn?=
 =?utf-8?B?ZE9DRjR0VFo3VVZqQmZORStHcWhneWxGNDAzUGd6a1VkVk9MVXJEWDNWZUMw?=
 =?utf-8?B?Ym1aWTh6WTFaVzVyZlNEeFU0czBoMFVKZW1iZ1RKd2hjc1dSMXNrZXBnSGFJ?=
 =?utf-8?B?b1RQOWIxQlZHK1N1ZDhyc3E2WUY4TytNQSt0c3pxaTcyZk9ZeVB2Ti8xNDdn?=
 =?utf-8?B?RjRGRGxna1Rhbm1MMVNVczJTQWtLcG1NQy93YXR4eGVadDFwVGozcmVDdzh4?=
 =?utf-8?B?Z2QrYTdxaHBYMTJJU2Z3UWN2SXVpVEZrbnpqelNzbmFlNlovWjVHZGUwQThj?=
 =?utf-8?B?bzNKVk4vTlZtOEEvQWErbjIwZFA3SmxKbDdUQXZiMEtURWlrc0djWTEvSXoz?=
 =?utf-8?B?TFQycFZtYytEMS8wWXlJYnVJc1RsZStTaTRtL24xYkVRaUZtV3BtcTNWZ0k4?=
 =?utf-8?B?Sk0vSTFBT2xaaHpKYy82dE5LNGt2SjdaVTZ5TldUbWI4Q3VKS1dNNUhlRUhO?=
 =?utf-8?B?VXNjcUFJajVkUlpFTm0zbTFNeEFjbjJZSWtiUlh4ZmptVHFUaGNiczBrMm8z?=
 =?utf-8?B?OVp6YTVJc2lhN1BJdU1JRGtFcCtNbmVkMUJndUQ2UG1ZQTlYRkVFWlNvd2hP?=
 =?utf-8?B?RXpTby90RktVUWZDZnh0RWtCN3o1Wjk5M3FBRDhaTVQ2Y3YyU0FncU9ubi9L?=
 =?utf-8?B?QldMS2FHeTJsbG1UYVFWemEycnppUnB6a1lHSklTVkVJU01FeWM5UHF5bXJJ?=
 =?utf-8?B?emYvcHA0eEpqYzhNZlFUNVVwOUZpZjFzb2FJZkRPQ3JHMmh1ZWtCUVlJZmp2?=
 =?utf-8?B?eXJRdXhxTGF4QnNTcWs1U1hveFdaZ0tXcFpmMjVzejU3bXZiLzJSTXhIais3?=
 =?utf-8?B?RUYxMlMzRDRmeTdMQVdCbmRMc1FDZ1luU0tSd1NyYWxrdklyREoxTi9TaU9L?=
 =?utf-8?B?QXBlckFGTEIzMWJJR0UxUGwxK0ZWOFlweWRUQnZKbUdrQjlkRzQ4cUVTQ21T?=
 =?utf-8?B?VEgyeE9MNnN2MXlIY2ljZGppSUovTTdCb2JuTVRJeW5qNVVnMkpLc2t3QzdC?=
 =?utf-8?B?NjR3UmZvRzFUSnVIbUhZQS8xRTY1S095N1pPdmF0clNvUS8wUzdrOE5oRGdv?=
 =?utf-8?B?Sjh2N3hhTUxzdmVPY3RDRU41OG1oelo4MVlZekJ2VVA2ajRHQnVsVzdsMVJn?=
 =?utf-8?B?ZWkzbDM4WmUrZ1JRWTllNTVYdjdmbUFjaW50SGx5b2xidEtSL3JnT1ZmYko5?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7971BB09449FFE468A0CACAF6D0331D2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QXtIcCwWR1j23q0cHLeAjNvw0es8fg23l3IVHBCFUlj9ixAuyws9KRVWSPaKoXu99W3SJwh1C60oG7FQIc65QjPLY5UM/w6uv5hN4Mg+vMH46Biqh7f5t3ckxHKdM096l3sQJb3hOe9N20h1OGNNVRRx0D3Bwupn5Sv/XRPFIl5AbvHRjiRVs5c3ua35lcKrn11Tn1TVdlw69O372uDukQ+H25dGLcpEzY+DAyTFiNaUMCzl8hSE8IVTXI3sHASTm/CAYCb6KUs9o7BtQbfhK0B0Tv9dztZbiBCM3VRuDPauaZpO5rmA/SOVg4oVDnpDfTNbRhQSNP/jX5GsgN/SvVSnykwzESK5aiu3MDFJc5iKsxMblQRcvTr+mZD9J+zMvQpg2qctSGDY3rHIhdYfG8iusy1oEEhnPwSaiacPCCQz3DG3Gu+XRUbs3HdOiEFkSKup/MpsQX3NPmTdC9EDrZBEf+4Y+kw5zvxpqhCGvPPN/WbBBge5fQpzww6IvXwWMbZJDgyDeGJGw2mCEJGTGR9bL8iEttXH6iX/9P6M537AxBAREnAedoF2PxvjhUa6flptiF/wLxUuuJgP+hKzwaYKMoNNy75VZkaN1Ndv6JTVVd2r/30L4/w6znmvxwpf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3939b9af-bf1d-4bdb-a4c1-08dc3785c3a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 11:18:03.1891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UbSE4ikOrxpFvRu/Pm54OQ+8dnXjHsE5n/mzZd29uAubtR6wxy+g0MtQbG+7zLGaAAxuVrk7JoGuZS4nokcjZMrkpwRApHXaMimDnBIJPMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7661

T24gMjYuMDIuMjQgMTg6MTYsIEFuYW5kIEphaW4gd3JvdGU6DQo+IE9uIDIvMTUvMjQgMTc6MTcs
IEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IEFkZCBhIGZpbHRlciBmb3IgdGhlIG91dHB1
dCBvZiBidHJmcyBkZXZpY2UgYWRkLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRo
dW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+PiAtLS0NCj4+ICAgIGNvbW1v
bi9maWx0ZXIuYnRyZnMgfCA5ICsrKysrKysrKw0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9jb21tb24vZmlsdGVyLmJ0cmZzIGIvY29t
bW9uL2ZpbHRlci5idHJmcw0KPj4gaW5kZXggZWE3NmU3MjkxMTA4Li5hMWMzMDEzZWNiNWQgMTAw
NjQ0DQo+PiAtLS0gYS9jb21tb24vZmlsdGVyLmJ0cmZzDQo+PiArKysgYi9jb21tb24vZmlsdGVy
LmJ0cmZzDQo+PiBAQCAtMTQ3LDUgKzE0NywxNCBAQCBfZmlsdGVyX2JhbGFuY2VfY29udmVydCgp
DQo+PiAgICAJX2ZpbHRlcl9zY3JhdGNoIHwgXA0KPj4gICAgCXNlZCAtZSAicy9yZWxvY2F0ZSBb
MC05XVwrIG91dCBvZiBbMC05XVwrIGNodW5rcy9yZWxvY2F0ZSBYIG91dCBvZiBYIGNodW5rcy9n
Ig0KPj4gICAgfQ0KPj4gKw0KPj4gKyMgZmlsdGVyIG91dHB1dCBvZiAiYnRyZnMgZGV2aWNlIGFk
ZCINCj4+ICtfZmlsdGVyX2RldmljZV9hZGQoKQ0KPj4gK3sNCj4+ICsJX2ZpbHRlcl9zY3JhdGNo
IHwgX2ZpbHRlcl9zY3JhdGNoX3Bvb2wgfCBcDQo+PiArCXNlZCAtZSAicy9SZXNldHRpbmcgZGV2
aWNlIHpvbmVzIFNDUkFUQ0hfREVWIChbMC05XVwrL1Jlc2V0dGluZyBkZXZpY2Ugem9uZXMgU0NS
QVRDSF9ERVYgKFhYWC9nIg0KPj4gKw0KPj4gK30NCj4+ICsNCj4+ICAgICMgbWFrZSBzdXJlIHRo
aXMgc2NyaXB0IHJldHVybnMgc3VjY2Vzcw0KPj4gICAgL2Jpbi90cnVlDQo+Pg0KPiANCj4gV29y
a3Mgd2VsbCB3aXRoIGFsbCB6b25lIGRldmljZXMuDQo+IA0KPiBXaGVuIG9ubHkgdGhlIGZpcnN0
IGRldmljZSBpcyBhIHpvbmUgYW5kIHRoZSByZXN0IGFyZW4ndCwNCj4geW91IGFyZSBzZWVpbmcu
DQo+IA0KPiAtLS0tLS0tLS0tLQ0KPiBidHJmcy8zMTAgMXMgLi4uIC0gb3V0cHV0IG1pc21hdGNo
IChzZWUgL2ZzdGVzdHMvcmVzdWx0cy8vYnRyZnMvMzEwLm91dC5iYWQpDQo+ICAgICAgIC0tLSB0
ZXN0cy9idHJmcy8zMTAub3V0CTIwMjQtMDItMjYgMTk6MTc6NTEuMDkyMzI1MTg4ICswODAwDQo+
ICAgICAgICsrKyAvZnN0ZXN0cy9yZXN1bHRzLy9idHJmcy8zMTAub3V0LmJhZAkyMDI0LTAyLTI3
DQo+IDAxOjA3OjEzLjA5NzYwMzQ5MSArMDgwMA0KPiAgICAgICBAQCAtMiwxMSArMiw4IEBADQo+
ICAgICAgICBEb25lLCBoYWQgdG8gcmVsb2NhdGUgWCBvdXQgb2YgWCBjaHVua3MNCj4gICAgICAg
IEVSUk9SOiBlcnJvciBkdXJpbmcgYmFsYW5jaW5nICdTQ1JBVENIX01OVCc6IEludmFsaWQgYXJn
dW1lbnQNCj4gICAgICAgIFRoZXJlIG1heSBiZSBtb3JlIGluZm8gaW4gc3lzbG9nIC0gdHJ5IGRt
ZXNnIHwgdGFpbA0KPiAgICAgICAtUmVzZXR0aW5nIGRldmljZSB6b25lcyBTQ1JBVENIX0RFViAo
WFhYIHpvbmVzKSAuLi4NCj4gICAgICAgIEVSUk9SOiBlcnJvciBkdXJpbmcgYmFsYW5jaW5nICdT
Q1JBVENIX01OVCc6IEludmFsaWQgYXJndW1lbnQNCj4gICAgICAgIEVSUk9SOiBlcnJvciBkdXJp
bmcgYmFsYW5jaW5nICdTQ1JBVENIX01OVCc6IEludmFsaWQgYXJndW1lbnQNCj4gICAgICAgLVJl
c2V0dGluZyBkZXZpY2Ugem9uZXMgU0NSQVRDSF9ERVYgKFhYWCB6b25lcykgLi4uDQo+ICAgICAg
IC4uLg0KPiAgICAgICAoUnVuICdkaWZmIC11IC9mc3Rlc3RzL3Rlc3RzL2J0cmZzLzMxMC5vdXQN
Cj4gL2ZzdGVzdHMvcmVzdWx0cy8vYnRyZnMvMzEwLm91dC5iYWQnICB0byBzZWUgdGhlIGVudGly
ZSBkaWZmKQ0KPiANCj4gSElOVDogWW91IF9NQVlfIGJlIG1pc3Npbmcga2VybmVsIGZpeDoNCj4g
ICAgICAgICBYWFhYWFhYWFhYIGJ0cmZzOiB6b25lZDogZG9uJ3Qgc2tpcCBibG9jayBncm91cCBw
cm9maWxlIGNoZWNrcyBvbg0KPiBjb252IHpvbmVzDQo+IC0tLS0tLS0tLS0tLS0NCj4gDQo+IEkg
aGF2ZSB0aGUga2VybmVsIHdpdGggZml4ZXMuDQo+IA0KDQpBaCBvaywgZG8geW91IHdhbnQgbWUg
dG8gdXBkYXRlIHRoZSB3aG9sZSBzZXJpZXMgb3Igc2VuZCBhIGZvbGxvdyB1cCB0byANCmZvbGQg
aW4/DQoNCkJvdGggaXMgZmluZSBmb3IgbWUuDQoNCg0K

