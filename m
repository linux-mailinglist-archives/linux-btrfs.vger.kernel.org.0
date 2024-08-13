Return-Path: <linux-btrfs+bounces-7161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CF295033A
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 13:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDA71C22705
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 11:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C842198A0D;
	Tue, 13 Aug 2024 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ori1acDR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c4T861Dg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F319755E;
	Tue, 13 Aug 2024 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547104; cv=fail; b=P+IJZHVG2bKuuLeRyf0eGBTBtruhSxcwq+V5y0cMTOxx+8HDlyezr3rLefy2zh6Y/yh45iNIO5CoSibGQANDp7+57wbg/q7kRYzkK6Hhtw8dyVq04sIU7WiHchSYIvCi1wBAD9pQZFh2DspmRjOdoF8Bb9d1MnO1hi4ULQU9VBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547104; c=relaxed/simple;
	bh=5tvsqMs2dqPfs+WEPB3c8lu31xr8ICgKTyZBHqD7iRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FcQnLJPzeSX2i6Cr5r/UApWr29RWgBahMjmD9XsKgscCW9tBX1F7rmu5m+2ORTWjdQrQ8xH3Bg+ms8z1/DgKCPG7UJHoZUcZy7pp+Sc/zlUMw6x85dRkTE44Q0s0ZOZL5YYVz1k0rvkdZQFTqYTAR3PhOeLrowUZIrnjRZq3ciQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ori1acDR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=c4T861Dg; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723547102; x=1755083102;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5tvsqMs2dqPfs+WEPB3c8lu31xr8ICgKTyZBHqD7iRU=;
  b=Ori1acDRhqJEc4aJ7dM7WPTZLEsLQyZnr4mK1N/WM0F+chm6/o9ObHWV
   MVVtGTxPsWjg2c/cBW7zdLBmJbYvFwDzs+lYs1kCBsK4OqjOi1NyJG+8Y
   NizoiK1jq4C6MIbTvqjTVDvTQmuDiR0/O76CKecMDZDzQIbp36DRvGx8g
   H7lCnAAol72bWkwLP4NYAsc0hdljMxR2dBZy5V6h7gn9kvBwsy3bQCZ8B
   zi5ESiIDinAEQ+c+s5PH4OXagSCkDJjrpF6Y1XoPXprhWjMJxPBL0hvpe
   gTKdQficdjENSTcSGSqzv59B+9e0s2SM58pbfDSfl/A9k8I4kwchpMABr
   g==;
X-CSE-ConnectionGUID: B19Pgb4KQOiC3Bulq0av+Q==
X-CSE-MsgGUID: u+r9NU1nQzuvc+RmeGf8KA==
X-IronPort-AV: E=Sophos;i="6.09,285,1716220800"; 
   d="scan'208";a="23544446"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2024 19:04:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/N+qufI8Gv2FAqljW120yQY2yGdPVSOqzcjtrZfXQTNmqLgYZcx+ZzQlwjgBmNtGr7pL7Eb/vPn/Ky+jXXvQEcrn75KGuLwmLqGzjkCrXtjo8ch/wjZB8WV4IOddRyt0s38gDvKGSnTC1VfR+MfI8WB5jtvQs3+3Gzgez4Xa5gwuLbqs5ylmhgiWLENLd+XReTlPvAy9r79Twal+8Y2PmqKBNbqhBPtLuF5xPI1qTd8jSVCMkNKRmdWxeEkTH8Ms5yUWBgPJVCpQm9dAs/bKZPBYZrRcR4JNtNwlxsxnirwXtUbl8gYqe+Vr6AjbU/JEEXYLIsP84kGT8HTbwLDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tvsqMs2dqPfs+WEPB3c8lu31xr8ICgKTyZBHqD7iRU=;
 b=LTectkifBK47hDB8mKpO9xPLRivkWYvPbwXibM4N5TmswbVy3T6K6hMVrDR7uHrJMBuUE2mCSmwopk66wtYTNusJyGDT0Wq3KIwTLcBQME57SdLv7qZlcRIrzD41McbOmRIt5cnRxy0/UjCVvdutrC1oKsc6sYQzgJztlcGFm9wU6gr1/swEsE+zREJC2jzKbp0IlIi5MePni1pRufembwUwcShzPJlOiciYVmhxzrH5IDUWUebdoJk0ZafFrQlXQLIRqMrgLO7z0qmK1NGFYAckR0aDNi3Qfs7fLuHNR8PTPtjAtO/aXPLo4rMXIugTH5fbw1YygVYppZ0/BDzqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tvsqMs2dqPfs+WEPB3c8lu31xr8ICgKTyZBHqD7iRU=;
 b=c4T861Dg+mCK5+8mI7dmJBzpDFyZcJLOJfzNrQktzuKIqd/m1iQna16TSzQ3Da3UDFV3djDA3nNe98ywmUJpNMLNq2RJou9aO9y87FTv/5I7yaG6UYG/sBIYaKToA9Mg5cRnlehvr1NjAjmHWTE62fRdz/FN+ISYVkVhtjwIbHE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW6PR04MB8842.namprd04.prod.outlook.com (2603:10b6:303:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 11:04:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7849.023; Tue, 13 Aug 2024
 11:04:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "open list:BTRFS FILE SYSTEM"
	<linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Qu
 Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2] btrfs: reduce chunk_map lookups in btrfs_map_block
Thread-Topic: [PATCH v2] btrfs: reduce chunk_map lookups in btrfs_map_block
Thread-Index: AQHa7W6HbDuWQgv9JE6rxwBSASEQ/7IlBCqAgAACNgA=
Date: Tue, 13 Aug 2024 11:04:52 +0000
Message-ID: <603670e6-e0c6-4f54-be6d-272042861bce@wdc.com>
References:
 <bc73d318c7f24196cdc7305b6a6ce516fb4fc81d.1723546054.git.jth@kernel.org>
 <CAL3q7H5jwR75FwT213yteX5m=5G8ehKmnKxv=xYXbY+UuhP+qQ@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5jwR75FwT213yteX5m=5G8ehKmnKxv=xYXbY+UuhP+qQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW6PR04MB8842:EE_
x-ms-office365-filtering-correlation-id: 5efa81be-82bb-4909-67bd-08dcbb87c1dd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SmVwYURSMkNhdStNUzZXZi85WU5qZTh3V0plYTBxOFVaVENISVBrTWd1K2JY?=
 =?utf-8?B?THFlQnBDenVqbnpVb0tVWU1vd05mdzI2RmlSYUp6NUJsQmFjNm9RelR0RUNZ?=
 =?utf-8?B?RlN4R3kwVlNta1RhN1dHZ3dDdCtvZVRxQnBmcU5Ca3c0eERLK2swS1p4cC9F?=
 =?utf-8?B?cTZMWjBFZnVYTndsbXF2Nm9QaXFoS20yRFAyd0FDcU1yYnAxSmtITTgyLzhw?=
 =?utf-8?B?QWV1UnIwb0d3cjE5OERnblhwSFRpQ0VPOGx0ZnRFY0wvZ3BLRlBVZGZlY0VJ?=
 =?utf-8?B?eVpUT2NseDEvSVhtWk9TRzRNdUZlTFBxS210RkZKak1PUGlCS01IVlEwNzNo?=
 =?utf-8?B?NGJHZ2ozZFMxREdJdFpvRWp3czh3YjgzNHVOSUdvNmtNdUVpTllVeXZURVVT?=
 =?utf-8?B?czV5aTZxbmlmL0Uvc1BVZnZNRWlFOTRYTzdWV3lmaXh4SU5hSFZScGoxZm44?=
 =?utf-8?B?SnFacEQ3UTBEZFlxOExzYzd5N0JobmdqUlFWYkxra25aK2dXb2h2Ykc1UU5G?=
 =?utf-8?B?UWd5dGR5SWNQaE96b0NpWHlETHdMMzF6ekVGYkR2Q0NQckJHQ1lRYjd2eGJS?=
 =?utf-8?B?MEZCaE9QRXpkcVAxWFZYVlhwVmQ0NlhPQzFXanJ2MDFsS2tEclQvR0lvSmR5?=
 =?utf-8?B?WkV1aFBNYk5hN3A4L1YwUSs3KzFIYjFXUFlqRUtoOTFRK1FZUWl5cDFXUmd3?=
 =?utf-8?B?bHFaMTRNSnQwaWxPcnRwNHZMSWJQRkpxSVBjYmtKTjZrcWxkemFONGVKRmVP?=
 =?utf-8?B?N2x2ZVFhSjByallTNmhUTEhQazlmWU5MeTFuV1k0NU5YQU4rcm11eFh3dDVw?=
 =?utf-8?B?ODZWNzlGd3lrQitta0xyRGxLL2pwTjNyd0VHT0wyR0NFZmE5VVpjMnMrZ1Vr?=
 =?utf-8?B?QXdBT3pZSlN4cSt6UWp0MnRNTis1OGZnOExtNVZoeEp0WElTY1lpalM0RXMx?=
 =?utf-8?B?VFZ6VGJRY3RkR3l0cCt3c0NSUFMvNGd1SE5nbWlUVEZmTFB4TDlYMldzVVlS?=
 =?utf-8?B?K2wvR25aSUhhcjlXY1BTTy9DbHhVMGkvWXhrMEV6RUpFZ0ZNNE8yN3lzWUxi?=
 =?utf-8?B?TWo5UlpSbWRvbWxYdUo0MWcxdFR1MTkzWVlLV2Z2MDBja2d6d1NOeTV4RDhD?=
 =?utf-8?B?NEpzMFhhTEhiT29hMDErcFRpL0NTRjV2UUVZYzcwTmVZRjA1Mmh0Tlc5dS8v?=
 =?utf-8?B?N2RVa3Fydnd1aFEwYVFTS3JjNU5oampjRHdWVGdSVkFoMmNpdUs4LzVIUmZM?=
 =?utf-8?B?Q01nSG1UWGk2UG1SQ0I3QXpCUnNic214SDhRSUwxdklvSDMwR2p4YzdrVDgx?=
 =?utf-8?B?cEJFY2JZMm4vcUg0bXZjWndNVmtwTmh0UjVjaThhbFhyRWhvb2RFd0tveEEr?=
 =?utf-8?B?WXRXaW5ML1pmaGFkUXlwdGQrWGp4dXNlOFh5cWR3MTRLVWhwbXhFTHZiOUJS?=
 =?utf-8?B?Zkp0LzRuRTFkdXE2VERrTHQ5SnBlV29QaFErSlZFYzFLMTVLejhzdEFLQ1Zv?=
 =?utf-8?B?bHl3Sytvbk1CNHJsYXpPYVl4VVZpRjBCcm5RSFFZeXBHSjVjL3J6cUhBY3l2?=
 =?utf-8?B?VmMwSVZ6VTNuSTVkQ0FUZUxaWFZWSUQxOUZGV2pWMVVvUTcwV2pkMVhDQzNt?=
 =?utf-8?B?NGxYbzJKZVA1Vng0b1Awa3JpUGl6UXR2aE5JZ1Rmb0JLRzV0U3kyaUorK2tX?=
 =?utf-8?B?VkZqNlduMlRTN3pOT01YUU01SUZENmxFMTBibjltS3RnazhObFdGaVIya01X?=
 =?utf-8?B?aC9HRWxHQStYNFUwUEVpOTgzMzJRb0x2ZVFwYnliM0J6akdOQWtuQUZKdEc0?=
 =?utf-8?Q?wyS9VSA5RrOP0H2/bTq/8bfZwy15+m/62zvK0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWpXZnNDVm41YVg5RU53YjAwRFlqajhLWitWMEN1MEk2MU9SSmlBTmlrT28r?=
 =?utf-8?B?bXlZbUR3cVZVTU1mYUtwL1FBT0NCaUxFRmpabkRkODJzSXBiN1NzdlA2eUlo?=
 =?utf-8?B?UXhuVFB6blRUdVQvamVvMVdySnBKakl6enZMdlc2RXZvN1ZSR25lcHhHcGtE?=
 =?utf-8?B?WjhQTVVtQlY2RmdQdlgwbG5HV3R1dFJlOGZoN2V5L0lGdm1ndlVkUVp0R3Bj?=
 =?utf-8?B?UjNVZkw2SkNHVHJVdHhtN1VCemZRcUp4Y25rbmJnRFZBa3IybFVDczJhVjI3?=
 =?utf-8?B?TXc2bk1yZGtoR2FMeDBIaThuTkJmQ0RpeXVySXV6UTRFdGNuR1B4c1drYmNh?=
 =?utf-8?B?NU9XLzJXWVl3dWkraHgwRnp0TjF1RkNhbzh5UEN4N3JnWmtza2ZxRHczd2Ny?=
 =?utf-8?B?elE1am1uRU9tZmp0UUZmR0lBTlhsc2d0enFhRWQvV3NPaWtQUjRIVFdEVW1Z?=
 =?utf-8?B?TzE1UDk4MWVNZ3lzcTJVNGx1UG9KZ0JqMzdqTHMrNC95YisrQkQxUXJPNDFa?=
 =?utf-8?B?YzNOS0hsd1ZqV0h2bUJZOVcwSEM0M0lLTkx1K0ZrdVBpbGlzL3UvY1N5enRj?=
 =?utf-8?B?elA4cHdpRk1rd3Q2SkZ1cE5mZXRkMzZTaEUwcmZXN3dSQmp1NlZGbEVabGto?=
 =?utf-8?B?VVFGdWU5MHRKYWZZT1lLNCtNQUlHQVJaeXVRSjErK2tiOG5IRlRaUjg1eUdi?=
 =?utf-8?B?aXZCcnV2VVNDSW5sdVAybmJLT2FJQXFxcFhvSm5tN2R3K211ZGlIUE1uSWRt?=
 =?utf-8?B?eGNGZm9Fc3Q0TlJiTzZnU1Y5ZnlqdFVQRjZVbHViQmlaOVJ2MVFjdDRVRWVj?=
 =?utf-8?B?TzRnNjVHM1pUZ0dlc2syQ1hQRk16Q2l3eDZOQm13WlRCUkdwNzBGSXRXY0tk?=
 =?utf-8?B?L3VEdjJTM2VldUZUUlpNandnWk5ZWmNzc05hbmkvaVdYb25wb1ZkNDRRbDVT?=
 =?utf-8?B?WTFxbytjSzVic0hBR25lNklwNktlaG1iR3U5YXlDZ3h5Rk5zVlZTSlBCNGY0?=
 =?utf-8?B?ZmdJbkJJaGwwZTZvZTd5MHo2N2NTNTg0N0Y4Ym1oY0hMNnd2ZGpKRklSUDQx?=
 =?utf-8?B?bkRiaW8xcGlrNHJ6bkJVWkQzK2l5QkxsU3B6bEN2dlk3NGIwckszWUkxUC95?=
 =?utf-8?B?RE9NSDVRRFBGcWFEZlpiTVZxSUtjVWMrb3VER3RzaUdzK3Arenlvc29sVXQ1?=
 =?utf-8?B?ZUl6SUFqcUh5MzBNS25ZWW9sNVFQeEZTVlZYTTg5K1pKRHdYM2R0SEU3VW9S?=
 =?utf-8?B?ZVpCMWtMQ3NzSnBMc21RL1ZHcFJvaDVPYnJhMzllL2toZDV6c3NNQlVKZjRI?=
 =?utf-8?B?VUJqN0liUjdiNE44WDE4U1dYRkJjaThMQlAzMUZRa3dWdkRiOWlzTjdzOFlp?=
 =?utf-8?B?OGE2STFjSjI3TWVRT0UwdTNvaEdxZStKai9Gd0kwTUcxQ2xDMTFMa0ZQSmFK?=
 =?utf-8?B?Zmsza0QxYWxqb25hVEhPYm4zeGc4Z2RVWUhYSSthdUYrMkVPajVGMGFobFRr?=
 =?utf-8?B?eWs1aFp1OHZpSEFrdFExamVZaHEreTBneWZNZnNLTFg1Sk9lM1EwMndUWk5m?=
 =?utf-8?B?MEtVYkVlRmZoVGh4SW1yL1FSMytlRHlYU3hJK0hKOWx0ODRNemxuYVplckN5?=
 =?utf-8?B?TTRuYVhiaGdJbGRDbjZkNzYwUktlY2dzaTcvRnNjM3dNWWZDVGNlVm1KdGJU?=
 =?utf-8?B?UXN0TUhKVGg3SGx4aVp4dUIyZkNXaDZhSFk0RnJSRXVKcGhLdldhc05yRUk0?=
 =?utf-8?B?QkF3V2dIdHV2aGF0R05xWld2WHJXNlRPRTNjT1RLY3VWbWNwaE5uY3JsZDNn?=
 =?utf-8?B?RHZ4dlVTM1BIalZ3V3hWdTVmb1ZCRktrS21GdXJta001dEw2OXFUTzEwMmdZ?=
 =?utf-8?B?Q1BXRnpCUUNRTm5ocVJONFo3YWFzbDlxMFBiaU9UdThSRmhpd0JQVzZRSjFV?=
 =?utf-8?B?ZnpDU2lWMEJBeW5vRy9WWGtnMGFDbUdxdmFXTTU0RXBRWVd3NFJzYVVGZHg2?=
 =?utf-8?B?MWJwSmU1ZE9oZWVTby9mRDVkWTNhWGNDYlFGcjV4VkVSTUIzd0QyMUNCTjZp?=
 =?utf-8?B?Znl5dmkwTkJ2TFJvQzFrcGRENjltNWVFK3J5UmpoaDRjNmhzblNrNUtENVFB?=
 =?utf-8?B?L0FYMGtZQjhGRDF6a3ZHVnl6ZnFjeGhXOEFhbW9PVzIwSmE1OE92UVpQbm1G?=
 =?utf-8?B?aTg4dktkMFZNRUZTMWdJY2Y1MWlEMUM3bmlqQ2xONmpVKytGWmZjVVhDQW1R?=
 =?utf-8?B?MDl3b1ZYaGNHd2l6SUxnZ0tyMXh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17ED2AAE0D0D6C44A69984A565ACF5A9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ids/oWIJKTfFfVioHKU56OaMulJ6+/u8BQ9KfPeel4mwAx9nQh0GEEDQIpxPc6s7YFgWCLjSIkUE+xn7ugfkmLyoTV5V4m3tTRCB8QRGYZnUiFVwxoZBjnVXp50zX7TiMDqZ6qYOGPlkKL4KDUWwJEIN3mSabLItOdH/klM1DNKxi6nDLYU+1tBhCtRJN2r3vJm8lKdqoIUpnj3o8/rBf6JNGozT1H+xmBzjmHJuAdGnHmP6HigIzE/EBribce4HTPzTFO9uK7ubHV6XgNS8d1dhGzTcoblTjAJZ/xE+dJ2zKtKfJuZyYD3ujk1QiJDgBnLOEDZksy9RFx0PJqmH+i9mOPlzuevj3G5M16zMZU2zIha+1UuEbEV8AGxzPsTjBu4W9qW+jraxowPUGjXjTuVEmVe/IWL0DoUjax9J5kLGtiwfntWzZLDhmcZ+2zWIhsuRrvsGjQ2L8wY48dqRlg9oCTmUkp424SM2Xqy43qDR2N85I6DGyAFAxyS3rsNLdI1Li93veSHTB5aDO/hCoKNIs8m638zVlctQyipssooYsnf1aRRirUH11FbV3+TIR29UHpl2KWwS6VFWacMpq6/iPWlZFNdtfJpN3HMxHR5Xj1HaLOJJpvfyXnkjFN7n
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efa81be-82bb-4909-67bd-08dcbb87c1dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 11:04:52.7159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3XLjRpOBL2ThI9mihr6J/gsqXsr6yB0rPr3KR59uCGyhATZwwkLfNO6ZwkmmGi+/ki5LkAgkk6TpMi9x38R35rc22RUPbaEAW7X5g0u7RUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8842

T24gMTMuMDguMjQgMTI6NTcsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIFR1ZSwgQXVnIDEz
LCAyMDI0IGF0IDExOjQ54oCvQU0gSm9oYW5uZXMgVGh1bXNoaXJuIDxqdGhAa2VybmVsLm9yZz4g
d3JvdGU6DQo+Pg0KPj4gRnJvbTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hp
cm5Ad2RjLmNvbT4NCj4+DQo+PiBDdXJyZW50bHkgd2UncmUgY2FsbGluZyBidHJmc19udW1fY29w
aWVzKCkgYmVmb3JlIGJ0cmZzX2dldF9jaHVua19tYXAoKSBpbg0KPj4gYnRyZnNfbWFwX2Jsb2Nr
KCkuIEJ1dCBidHJmc19udW1fY29waWVzKCkgaXRzZWxmIGRvZXMgYSBjaHVuayBtYXAgbG9va3Vw
DQo+PiB0byBiZSBhYmxlIHRvIGNhbGN1bGF0ZSB0aGUgbnVtYmVyIG9mIGNvcGllcy4NCj4+DQo+
PiBTbyBzcGxpdCBvdXQgdGhlIGNvZGUgZ2V0dGluZyB0aGUgbnVtYmVyIG9mIGNvcGllcyBmcm9t
IGJ0cmZzX251bV9jb3BpZXMoKQ0KPj4gaW50byBhIGhlbHBlciBjYWxsZWQgYnRyZnNfY2h1bmtf
bWFwX251bV9jb3BpZXMoKSBhbmQgZGlyZWN0bHkgY2FsbCBpdA0KPj4gZnJvbSBidHJmc19tYXBf
YmxvY2soKSBhbmQgYnRyZnNfbnVtX2NvcGllcygpLg0KPj4NCj4+IFRoaXMgc2F2ZXMgdXMgb25l
IHJidHJlZSBsb29rdXAgcGVyIGJ0cmZzX21hcF9ibG9jaygpIGludm9jYXRpb24uDQo+Pg0KPj4g
UmV2aWV3ZWQtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEZp
bGlwZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSm9oYW5u
ZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+IC0tLQ0KPj4gQ2hh
bmdlcyBpbiB2MjoNCj4+IC0gQWRkZWQgUmV2aWV3ZWQtYnlzDQo+PiAtIFJlZmxvd2VkIGNvbW1l
bnRzDQo+PiAtIE1vdmVkIG5vbiBSQUlENTYgY2FzZXMgdG8gdGhlIGVuZCB3aXRob3V0IGFuIGlm
DQo+PiBMaW5rIHRvIHYxOg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwODEy
MTY1OTMxLjkxMDYtMS1qdGhAa2VybmVsLm9yZy8NCj4+DQo+PiAgIGZzL2J0cmZzL3ZvbHVtZXMu
YyB8IDU4ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy92b2x1bWVzLmMgYi9mcy9idHJmcy92b2x1bWVzLmMN
Cj4+IGluZGV4IGUwNzQ1MjIwNzQyNi4uNzk2ZjYzNTBhMDE3IDEwMDY0NA0KPj4gLS0tIGEvZnMv
YnRyZnMvdm9sdW1lcy5jDQo+PiArKysgYi9mcy9idHJmcy92b2x1bWVzLmMNCj4+IEBAIC01Nzgx
LDM4ICs1NzgxLDQ0IEBAIHZvaWQgYnRyZnNfbWFwcGluZ190cmVlX2ZyZWUoc3RydWN0IGJ0cmZz
X2ZzX2luZm8gKmZzX2luZm8pDQo+PiAgICAgICAgICB3cml0ZV91bmxvY2soJmZzX2luZm8tPm1h
cHBpbmdfdHJlZV9sb2NrKTsNCj4+ICAgfQ0KPj4NCj4+ICtzdGF0aWMgaW50IGJ0cmZzX2NodW5r
X21hcF9udW1fY29waWVzKHN0cnVjdCBidHJmc19jaHVua19tYXAgKm1hcCkNCj4gDQo+IFNhbWUg
YXMgY29tbWVudGVkIGJlZm9yZSwgY2FuIGJlIGNvbnN0Lg0KDQpObyBpdCBjYW4ndDoNCmZzL2J0
cmZzL3ZvbHVtZXMuYzo1Nzg0Ojg6IHdhcm5pbmc6IHR5cGUgcXVhbGlmaWVycyBpZ25vcmVkIG9u
IGZ1bmN0aW9uIA0KcmV0dXJuIHR5cGUgWy1XaWdub3JlZC1xdWFsaWZpZXJzXQ0KICA1Nzg0IHwg
c3RhdGljIGNvbnN0IGludCBidHJmc19jaHVua19tYXBfbnVtX2NvcGllcyhzdHJ1Y3QgDQpidHJm
c19jaHVua19tYXAgKm1hcCkNCg0KT3IgZGlkIHlvdSBtZWFuIHRoZSBjb25zdCBzdHJ1Y3QgYnRy
ZnNfY2h1bmtfbWFwPyBUaGF0IGNvdWxkIGJlIGRvbmUgYnV0IA0KSSBkb24ndCBzZWUgYSByZWFz
b24uDQoNCj4gDQo+PiArew0KPj4gKyAgICAgICBlbnVtIGJ0cmZzX3JhaWRfdHlwZXMgaW5kZXgg
PSBidHJmc19iZ19mbGFnc190b19yYWlkX2luZGV4KG1hcC0+dHlwZSk7DQo+PiArDQo+PiArICAg
ICAgIGlmIChtYXAtPnR5cGUgJiBCVFJGU19CTE9DS19HUk9VUF9SQUlENSkNCj4+ICsgICAgICAg
ICAgICAgICByZXR1cm4gMjsNCj4+ICsNCj4+ICsgICAgICAgLyoNCj4+ICsgICAgICAgICogVGhl
cmUgY291bGQgYmUgdHdvIGNvcnJ1cHRlZCBkYXRhIHN0cmlwZXMsIHdlIG5lZWQgdG8gbG9vcA0K
Pj4gKyAgICAgICAgKiByZXRyeSBpbiBvcmRlciB0byByZWJ1aWxkIHRoZSBjb3JyZWN0IGRhdGEu
DQo+PiArICAgICAgICAqDQo+PiArICAgICAgICAqIEZhaWwgYSBzdHJpcGUgYXQgYSB0aW1lIG9u
IGV2ZXJ5IHJldHJ5IGV4Y2VwdCB0aGUgc3RyaXBlDQo+PiArICAgICAgICAqIHVuZGVyIHJlY29u
c3RydWN0aW9uLg0KPj4gKyAgICAgICAgKi8NCj4+ICsgICAgICAgaWYgKG1hcC0+dHlwZSAmIEJU
UkZTX0JMT0NLX0dST1VQX1JBSUQ2KQ0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiBtYXAtPm51
bV9zdHJpcGVzOw0KPj4gKw0KPj4gKyAgICAgICAvKiBOb24tUkFJRDU2LCB1c2UgdGhlaXIgbmNv
cGllcyBmcm9tIGJ0cmZzX3JhaWRfYXJyYXkuICovDQo+PiArICAgICAgIHJldHVybiBidHJmc19y
YWlkX2FycmF5W2luZGV4XS5uY29waWVzOw0KPj4gK30NCj4+ICsNCj4+ICAgaW50IGJ0cmZzX251
bV9jb3BpZXMoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIHU2NCBsb2dpY2FsLCB1NjQg
bGVuKQ0KPj4gICB7DQo+PiAgICAgICAgICBzdHJ1Y3QgYnRyZnNfY2h1bmtfbWFwICptYXA7DQo+
PiAtICAgICAgIGVudW0gYnRyZnNfcmFpZF90eXBlcyBpbmRleDsNCj4+IC0gICAgICAgaW50IHJl
dCA9IDE7DQo+PiArICAgICAgIGludCByZXQ7DQo+Pg0KPj4gICAgICAgICAgbWFwID0gYnRyZnNf
Z2V0X2NodW5rX21hcChmc19pbmZvLCBsb2dpY2FsLCBsZW4pOw0KPj4gICAgICAgICAgaWYgKElT
X0VSUihtYXApKQ0KPj4gICAgICAgICAgICAgICAgICAvKg0KPj4gLSAgICAgICAgICAgICAgICAq
IFdlIGNvdWxkIHJldHVybiBlcnJvcnMgZm9yIHRoZXNlIGNhc2VzLCBidXQgdGhhdCBjb3VsZCBn
ZXQNCj4+IC0gICAgICAgICAgICAgICAgKiB1Z2x5IGFuZCB3ZSdkIHByb2JhYmx5IGRvIHRoZSBz
YW1lIHRoaW5nIHdoaWNoIGlzIGp1c3Qgbm90IGRvDQo+PiAtICAgICAgICAgICAgICAgICogYW55
dGhpbmcgZWxzZSBhbmQgZXhpdCwgc28gcmV0dXJuIDEgc28gdGhlIGNhbGxlcnMgZG9uJ3QgdHJ5
DQo+PiAtICAgICAgICAgICAgICAgICogdG8gdXNlIG90aGVyIGNvcGllcy4NCj4+ICsgICAgICAg
ICAgICAgICAgKiBXZSBjb3VsZCByZXR1cm4gZXJyb3JzIGZvciB0aGVzZSBjYXNlcywgYnV0IHRo
YXQNCj4+ICsgICAgICAgICAgICAgICAgKiBjb3VsZCBnZXQgdWdseSBhbmQgd2UnZCBwcm9iYWJs
eSBkbyB0aGUgc2FtZSB0aGluZw0KPj4gKyAgICAgICAgICAgICAgICAqIHdoaWNoIGlzIGp1c3Qg
bm90IGRvIGFueXRoaW5nIGVsc2UgYW5kIGV4aXQsIHNvDQo+PiArICAgICAgICAgICAgICAgICog
cmV0dXJuIDEgc28gdGhlIGNhbGxlcnMgZG9uJ3QgdHJ5IHRvIHVzZSBvdGhlcg0KPj4gKyAgICAg
ICAgICAgICAgICAqIGNvcGllcy4NCj4gDQo+IE15IHByZXZpb3VzIGNvbW1lbnQgYWJvdXQgcmVm
b3JtYXR0aW5nIHdhcyBqdXN0IGZvciB0aGUgY29tbWVudCB0aGF0DQo+IHdhcyBtb3ZlZCwgdGhl
IG9uZSBub3cgaW5zaWRlIGJ0cmZzX2NodW5rX21hcF9udW1fY29waWVzKCkuDQo+IEZvciB0aGlz
IG9uZSBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBkbyBpdCwgYXMgd2UgYXJlbid0IG1vdmluZyBp
dA0KPiBhcm91bmQgb3IgY2hhbmdpbmcgaXRzIGNvbnRlbnQuDQo+IA0KPiBJdCdzIGp1c3QgY29u
ZnVzaW5nIHRvIGhhdmUgdGhpcyBzb3J0IG9mIHVucmVsYXRlZCBjaGFuZ2UgbWl4ZWQgaW4uDQo+
IA0KDQpXaG9vcHMgdGhhdCB3YXMgZmF0IGZpbmdlcmVkIHNvbWVob3cuDQoNCg==

