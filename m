Return-Path: <linux-btrfs+bounces-7341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8E3958D9A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 19:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07481C21C04
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05DC1C0DF8;
	Tue, 20 Aug 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E4cTFi6b";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bA29xzge"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989A718FC9E;
	Tue, 20 Aug 2024 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724176059; cv=fail; b=iLg8yiy6IQGrKylkH44Y8zy7zDUvzSiTo227s5Q3Xnxq0dD+VN+Ge541TrU85zYbK/A+BHEgcD30lwipdAJIAqlGzCupknbZgSypMvqkNKtjMLD8+MWE5k3/Bw5Ol5vyZuCR/5t8RwiTkVhf289gkBBbZTUjNVNv6szRNYLzwtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724176059; c=relaxed/simple;
	bh=TwBQicJGxwImzYbDnNIBZYXRDX7SNgiM/0oKRlyYBOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oXxiRK0c0Wsxn4R8N49qVS2CldadWRTikQ+hGbpSP/5OU7UGrBHH63LiyasRpsYgA/c/xAy5n+YpyhGIRblA0cGkO66scoFliQT5CaMe6iH1II/jTVYE2pNLfEZf/7+yWU9u6hbkwpd0FINLmbGuKQaO4gNrO3d+K4I5S69bF+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=E4cTFi6b; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bA29xzge; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724176057; x=1755712057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TwBQicJGxwImzYbDnNIBZYXRDX7SNgiM/0oKRlyYBOc=;
  b=E4cTFi6bQaPlJpeTVfo4AhP9h4q+4rIf/dV8IUryb16WlpaXgT2kbsLp
   y3rWBrcYbdmeXkW6WrttQmKDRJuvY5o1M6QuptWNmJYL1vrtVvVw5SHGw
   NJ7wYFqu8pxZzIc4kM9oqRY8tiV33YNdxQEJoDNtX05DYl+Pf+Lq311NX
   h+OSPgHbxNfh7Mwmu8lVWrUm9JyI2b3FZBC5m+FCgi322q3RJ5AE7z9vR
   TwugL/HzbQDs2xpibqkoITQ8kbDUdG423E12aK8k4QhE3+x6Wv7szFCzE
   QRjbeTvJnCQXCoEj7LeXoI8893jSLd4FoltQg8z0cMc5D/t5sDXLlflhE
   A==;
X-CSE-ConnectionGUID: BrDOBYFUSwiJYI+mCWLc7A==
X-CSE-MsgGUID: jMh2vH99StSL5o4bm/Jd0w==
X-IronPort-AV: E=Sophos;i="6.10,162,1719849600"; 
   d="scan'208";a="24738193"
Received: from mail-mw2nam10lp2048.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.48])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2024 01:47:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/LoV1GDf2X7CZ1YwHNLGGlFh2nCZu+9O/ngopl5RpVuJHmWOfmMqLvLfHAjA/Y5XBkdOXtQ04NQb58TD1zscmv78Qn2VWfqmbOGvwHODWpnppO3u0GHycFbxpml+0HnUs96S6uoIIA8IdTNYPBdvIgfEIRMC8bYtOrm42pt/dNbdha/vXeFzUy7f9w+196kvesTnZUEOks+jeYvhxizIflkg/o+QpDH00Y3dMonBtMJhTaie533Q26TC0VFoxd8XBRNpUHHAUUN+AyTeHz4Vsmb02nh+SKVN+0duR6ojSxrV2BOog0JL+yQJfuAo8sOAcKs18sY1rvhNx+zCZRaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwBQicJGxwImzYbDnNIBZYXRDX7SNgiM/0oKRlyYBOc=;
 b=YbGo9pRGsZc0K7GrDo0rWv+baWaOQKgDVy/gkbQzxZ0QX32ZSblEqJKY5+489b1V0iuMrI7SxLdPvVmSpZD50bzEws4HEms45r3k9kWJwwtOV6D0wqMu5vTq7scfMaNDKfDAGCk7ke8RtX/pxL6lw0/FCrE4DJmPp8NAe66l5GuSDslnmSXA0DxAM3FA+CqZpER7v5bHI0FXst6UZu0Bef2Ai1g9HBWJXQSMEEjFNCJF2LSO9oX4chOh5Zk7uYiY1SiXitRdAxm8vaqKI/ya/OaWsRRrNQET8BzTbK3jjYnVjDebojB28zGhpHQxzLd3cxuoTJ3D1ISNvKmpAtlIZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwBQicJGxwImzYbDnNIBZYXRDX7SNgiM/0oKRlyYBOc=;
 b=bA29xzge3XM52RKQwjSkCx1fxofORGktXB6Pr1rGOQkdb+3TM+A+2qX0In+7upm4y45s2uMywhTMKWrLhVwHO82IXXHBLIUoRSEbSr/cFdzTYhI+LpbeHu/GJLo73oDbZF9xZENip2I6zJ/dsmS7xo+R40CIfSsaJZfP2PP6CgM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6593.namprd04.prod.outlook.com (2603:10b6:208:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 17:47:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 17:47:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, "open list:BTRFS
 FILE SYSTEM" <linux-btrfs@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
CC: Qu Wenru <wqu@suse.com>
Subject: Re: [PATCH] btrfs: scrub: don't mark inline extents as errors on RST
Thread-Topic: [PATCH] btrfs: scrub: don't mark inline extents as errors on RST
Thread-Index: AQHa8w4m6hDQv/uSzkKmb1eABBOcE7Iwa/OA
Date: Tue, 20 Aug 2024 17:47:31 +0000
Message-ID: <3ec1dd40-cdc7-4e47-9f74-9a29f60b6368@wdc.com>
References: <20240820143453.25428-1-jth@kernel.org>
In-Reply-To: <20240820143453.25428-1-jth@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6593:EE_
x-ms-office365-filtering-correlation-id: 6da31720-73d2-4858-193d-08dcc1402a90
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SmU5bVV4MHhtNjA4V1lnNlVVbXVvaVJNcUZyTm1uWmRFZXd2V3BGRzJSYWdm?=
 =?utf-8?B?d3ZySW9lSTVRQkwxOTZnN09PVHd1Z2pqUmIxK0M0czZrenBZdG9tbTlGaVo5?=
 =?utf-8?B?VmJNbU0ybytFSUxsRU80V2RobkRYOFhoNk8wU1VVa29IMkRQVU9oNVBDbEYv?=
 =?utf-8?B?bDJtblE1VkZEVjdjTHF5Tm9qK2JVUGZUWHRObHVIUGNDaHZFMzVxSkZmdlY3?=
 =?utf-8?B?OGRDTTQ1eStwdkEzV1I3L1M0OTE3K1hHY2tneTh3NUd1ZDNZSTJ3cGQ3blNo?=
 =?utf-8?B?VWJhblBkekJMKzJEclFPMTgwRnhOMEhVdGpXa3N3Ym1GN3NFSDd5R2FpeG5i?=
 =?utf-8?B?bUQvV0p0Y3cySXRJSHBDbkhkSHlaMExyYTZWelBwNk91Qk93d3dRdXE0M05v?=
 =?utf-8?B?YlB3WjdScHRjSG8xZGEwdVMwK1dLeW0zRU01VDlyQy9NK0ovQVJpanYwOTlr?=
 =?utf-8?B?Q0pLOC84LzJQamI1dUxtRmdFTHdCeXN4OS96cjVDZ0t6ZVhYVU0vdkNLQm50?=
 =?utf-8?B?T2Y0QitoRkd2MEY5K3dueEU1YWhQeDdBelR2QXFLTGJWQlpVdnYzdkZ4ZGIz?=
 =?utf-8?B?ODh4TExJM0YrYXVHckNMcjR6dkFKWVN5ZG02VEdZUTFDanRoZE5wTTJJL2tl?=
 =?utf-8?B?ZGwxc0kwNS9vZVJXRjh0VXN0cWN3bDQ5a0dpeGZ0ZHRnZy9IbkFVVjI4UnlY?=
 =?utf-8?B?TDRDSHd5MzluNk5yNW11TmJlS2tIZkJvTkcxLzE3MnVDa0p6bWtLV0Z4U1Jy?=
 =?utf-8?B?bEJwRWI5YXR3a3FaM09xRVh1SGwvWm05NXNkUEhOK0VwSUdkd0lCYW85Nm45?=
 =?utf-8?B?TS9va3cySGtjdmJXcjJiRlFDazA1VU5MeTVEeXhCaEM0dzhiRkxXeFFvbGNY?=
 =?utf-8?B?RzJ1NFU5THlkK1gwamtDV21Yaml5TEhkU2JpMkVybm1XODVjMFUyVTNlTEdE?=
 =?utf-8?B?bEpaaE1MaENmUi9saFkzZmwrbEtvUG9tWG8xSkdZcjdGdXFVOTJJbGF2UjZ0?=
 =?utf-8?B?WXdDYXdOMHoxUmVzNURFdnd0WWdibjVQa2FOL3gyc0hCbll4aW1LY3hjSU4y?=
 =?utf-8?B?eVdCbEcya3QyMnVrUi9PQVNna1MyWHJYOHdRdEh0YWI2dHBCWVl3bDVCc1li?=
 =?utf-8?B?MmcrdUdKb2Z1SlJRNmF6UzV3WTBlQi9SaDgyODlMbGFNdFRMNkNiL3JhK0tM?=
 =?utf-8?B?K0E3V0VPVEMzQ1FBZEd5eG80c3ozWHJoRzhVbVdvTGpIQ1NRTDJQRkFxZkhE?=
 =?utf-8?B?aG14ZlNZZG9ZZmFPYTF6cVM0ZTEzck1JTHl0aXllMm1aMThEREVFUGdGREFi?=
 =?utf-8?B?dGxSZTFrQmJhbERleEVzRTlpenNSdTZTU21VSVBVcGw0OThLMThVREdoRDVR?=
 =?utf-8?B?RFNjK0lINFpxYkxiNU91ZTdZS0lvL2VYVUNiSU5ZSHdrSGNaVGxwbmdnNUtY?=
 =?utf-8?B?Y3pIVHhOb0pnUndORy9rZjA2OGczMU5adlFHMXRXNW5WVVBIYWhmZHkxTHRC?=
 =?utf-8?B?Y09JdVBiWVZKYk9McDhRT2FsQmYybVpmWE0vZE9tcG4vZDVZMktnMGxhcm14?=
 =?utf-8?B?WWtjYzZ4bUtLVFAwbTdzVE0vQXVOK1JnNG95dW1jWCtmbnk0eDdkbk83MzYz?=
 =?utf-8?B?bTF1Q3VVT202WThNZXIxb2h4K2xhRWpHSzI4MTJEcVRMUzdwV1FSeWZrMUxq?=
 =?utf-8?B?cXRBeE5iR2RGcnJ2N2xNRkJHU3JZT3FqTW0va2NkeUZySzRpQ2lmU0VyWFJv?=
 =?utf-8?B?b2lueFZsdEVsaVEvTE83cWdVeUJuVXk0aE1EYWFqSG1aU3BGYitqQU9QTHp2?=
 =?utf-8?B?YUJ2bkl1OXg5ZHcvYno2UGt1YjM1VmJYcEpwdW9aSUNzZTFqaS8vM2tqakly?=
 =?utf-8?B?a1A3Rm5KSDNSdERPZStRQ1JOMGFiajRUeVNJQkpRN0VYaXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1k5TWF6ejlFS2Q0SlRzam1KUnBBTHdEbWNZdGdHbTJRa0hTU0NhcGJ2Y2JK?=
 =?utf-8?B?OERCZHN5a3htNVZ5enlyOElkNUpBcWNwYi9TN0g1SkFCTzBRTUxMZ1hoTzkx?=
 =?utf-8?B?MldZbHZ2alRxV0hHVTEwM1dhMEtoQzQyVEVFbmZadC91dXFJdkt5ZWs0cWpB?=
 =?utf-8?B?cUNTeXZOQnVUd2JYd0dXajIzMk9QbnpVWUJvVVY3R1kvcFlBd05wcnRiaDRq?=
 =?utf-8?B?V25xKzRnWUxudnU4dnVIMFZ6MmlOYnZQeUVTa3lHTVc3anFOQUphbzVzakkv?=
 =?utf-8?B?anp6OFJHcHVhQjNIaFB4M1FlTUZuWUxIR2psS2wxZXpIWEZjODYxZE8zYnhJ?=
 =?utf-8?B?a2tKbFFBaGZrWTd1My9nR05mYk1NQStUYlpaMDZIUDFPVTErRUE1SWIweGxG?=
 =?utf-8?B?Y3o0OTU0b0liNHBZb1A1Q0RpU0JnblNZaEdaYm92aTdyZGI2cjh1T0dNaUtD?=
 =?utf-8?B?QXdNeTRocVAzeUZEcU1GVDlXcndoVU9vb2t5RVJFUnRPdjAxbG1hc0JwWUdC?=
 =?utf-8?B?dDRWcG92L08yRzVma05tL21YeWpmaHdHTHhxRURzb3lJQnBwbCtvOXFMU21s?=
 =?utf-8?B?Zm5hUTg4cTFLekE2UUp2b09PTkhISkJYMm1UMEZnTnJlekVVbG1mUC9aVUxV?=
 =?utf-8?B?SjRUdTl3aG9sc3FMSHM3aE1mV2VZWUNYZHB2NUxzcFNiMGVHSkJUNjMwQlFu?=
 =?utf-8?B?UnlDRkVoSHAweGFsVnhlQzJ1aGNxT1hvM1ZRZDFzWUZVUFZnSnBYQzhiVUo0?=
 =?utf-8?B?ZkQ1bHBMZG0wM0UwM0VPZ0hvenJESGhadlF1SVVOLzBBck84NENLT2RlSmV1?=
 =?utf-8?B?aFhwcmxIcWpLM1ZmMFVZWnZ2VnlqUG1PdnppTUttVFJ6aFBRcDBDL1dtbmF1?=
 =?utf-8?B?VjlEWW83THVuVzBUSk8xNllocy9RcnZ6VzdLaFltUWFiVFh0MmJVNmpXeTZ4?=
 =?utf-8?B?cWZ3VGJVNDh2MERIUUwwaDNCRjJCamFwTUd4OXp1bk1MRXRxbWtaaEozNWR5?=
 =?utf-8?B?SlNYVUlWNVp2RzJVWU5UTFUzdjExcjA2cFRGa3RwOXl5UnhDSXlJSEp4U1Fp?=
 =?utf-8?B?Qk1jSXI3blVhSllocGo0dElxTnkwaVIya29XMFFWOEdRNWJNcnlDNEVTMmhZ?=
 =?utf-8?B?bHVIeEtQWnZHMFM2V0p3bGxYUjgyc2NyLzI3R0xVRXlmdEhXNFE3ZlM0RTFL?=
 =?utf-8?B?WFRDRkltdzY4cGpxUTh0eXFXd1I1SDlDOWhIUTd6cXY1dmo0czhKZVRrd3Jw?=
 =?utf-8?B?ay8yUXlpMmNLUGVaZW5CcHNzMDlBV0xrVmd1QVZoclFUZEwzNExCOHBjVUxL?=
 =?utf-8?B?eDZoaEEzbmRtZUVBMyt6ZVNUNlBYNGc0TGRqWUl1Ykd5cmxpWTFCUXZ5WGs0?=
 =?utf-8?B?U0tyWFNIQWltYUtFdVJqd0p4SUhJMlFtYlRMdm4xcDhvT0FCdXBMb3h0Q0Q0?=
 =?utf-8?B?T1JERjNwTER0OUV2cjVqSmszTTIxRzRIK0RIQkdMcWZ3UzgrVHN2b1dOR0lr?=
 =?utf-8?B?SlFHbTFVeE0vdWRnQ3BMUTBXNElPVUE0SmRTdHRUaXQ2MW9JNHFwTVFWZXE0?=
 =?utf-8?B?SWo5MXRIV1d1MmJnVlFkTVBOMFZJZEtIWWFGT3lPUml4QytCWVhwMVN6Qnpj?=
 =?utf-8?B?d0xkQWJObDJwN0FtdjZMczFYbFRzbC9YYVBVM0l6VjdtWW5xRUM2cUt2Wkxw?=
 =?utf-8?B?c2lmSlhjaWZPNzQrUklUWElDRkVLT3hod0F5WnpNbVdSQ1VhaHY4YzllajZU?=
 =?utf-8?B?NGtGV2ZMODVtR3pSb052ZWFESTFYQWZOU3VINkJ5dE05SVV1WUpFZVlsazZK?=
 =?utf-8?B?N3JSdm5UQ0ZyM1pPZlFXMVJZTUFudk5XdWpRZnZCVlNCdkp3MGVHa3A3L2Ey?=
 =?utf-8?B?d09aVGFQOXFMSXUvOFk3MUQrWjEvYmFSWEg0L2xRKzhhb3MxclN0cDBoc1VJ?=
 =?utf-8?B?N3hTSTNlQ25xQXB1b3A4MS9oejQydE4wVXVNMjVLQ09MWEFVaENoTlg3aFov?=
 =?utf-8?B?UE9hZ2xPdThGYnV6dEk5dTNRV3BySW9iNUV6YW5uTnlwZjV1YmREKzMvR2ZE?=
 =?utf-8?B?cm5lRTNpc0R1VUk2eTFkN2RIKy9TWGc1THJ0R3JPQ1BQNktuVDhtdmNWeEhH?=
 =?utf-8?B?UGI2a3pjVkxPOEx6cHdmKytYNzVaYnRtNmlMNEluTHJjcTllL1Q3RDJvSlRY?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <691E1C87A965354C9721C20B79F1D125@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CAcOxeoEXx2PPw98xoof6+HOs6dCemP7PX/HgezbM2ZP4YE9M4qz9C+RGBxkxNifL8CV172KejOJtGMtx9NoYV4Bos7AbVDLCU1nPtm2fRQ8rYiQJ0e5zv/O+1x9USszdUDozMlrKD6X14S6WnAmKqKUlxSaPMWeCDyYrOQ1J0ZZqdf8hogaFZqJZZPkVQR2jyGB5iEaL5b7/KVY5PC7THylwj4e6vaeuwo4QoAh/WM3N8fz0CjH7mcWXK1+PPHB7H4rbLJZP/UTeh+z0VJlPfPndqXfPo76X0kWZsg02BzPE0OUkB0LQ6CtrfcizlsnuHFdgQPuw498fdbbSsyb+I2DQWZ4Yi7gpcggMW0gMihXSq/RBbPXuRgsFel3naycSDIxCZgAzqyZ9/9CQkSfVnkStFXFSVH3MLAsOX0PfMoCbw66E90gvi+5rC1z5vRc7T4UHloAzKMrUEu0yA3WQugGpuQKw781GchcojgGb4ASUMCBJCEm/OkyF04MD/Tojt7FLfLjjeKw+hw/+qJ6A5SNNEkz85VVmgSzEuXCK/UMjOxnjyzjFTpMZwtBHJawoNZN2LTn5K77njB0BrFEqDu7nJoMi9arIQLfFWhL+J1QQxi5o/Eeo0B0xnjzGbsx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da31720-73d2-4858-193d-08dcc1402a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 17:47:31.5748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PhPLy4aaCjud2ReF1y49WGztTSpQxo6kZGe0PoS1+7CP3E6ePr2/B7A6KrWM+aFfABT5jATLNt1GR1SwtycdVaZ1yd6DZV0UF3sPStvnNug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6593

T24gMjAuMDguMjQgMTY6MzUsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gRnJvbTogSm9o
YW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4gDQo+IFdoZW4g
c2NydWJiaW5nIGEgUkFJRCBzdHJpcGUtdHJlZSBiYWNrZWQgYnRyZnMgc3lzdGVtLCB3ZSdyZSBk
b2luZw0KPiBleHRlbnQgYmFzZWQgYmxvY2sgbWFwcGluZ3MuIFRoZXNlIGJsb2NrIG1hcHBpbmdz
IGdvIHRocm91Z2ggdGhlIFJBSUQNCj4gc3RyaXBlLXRyZWUgdG8gZG8gbG9naWNhbCB0byBwaHlz
aWNhbCB0cmFuc2xhdGlvbi4NCj4gDQo+IEluIGNhc2Ugd2UncmUgaGl0dGluZyBhbiBpbmxpbmUg
ZXh0ZW50LCB0aGVyZSBpcyBubyBiYWNraW5nIGJ5IHRoZQ0KPiBSQUlEIHN0cmlwZS10cmVlIGZv
ciBpdCBhbmQgdGhlIGJsb2NrIG1hcHBpbmcgcmV0dXJucyBhbiBlcnJvci4gU28gdGhlDQo+IGJp
dCBpbiB0aGUgZXh0ZW50IGJpdG1hcCBpcyBtYXJrZWQgYXMgZXJyb3IuDQo+IA0KPiBGaXggdGhp
cyBieSBub3QgbWFya2luZyBtYXBwaW5nIGZhaWx1cmVzIGZvciBpbmxpbmUgZXh0ZW50cyBhcyBl
cnJvci4NCj4gDQo+IENjOiBRdSBXZW5ydSA8d3F1QHN1c2UuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQpTY3Jh
dGNoIHRoYXQgb25lLCB0aGF0IGFwcGFyZW50bHkgb25seSB3b3JrcyBpbiBteSB0ZXN0IGVudmly
b25tZW50Lg0KDQoNCg0KDQoNCg0KPiAtLS0NCj4gICBmcy9idHJmcy9zY3J1Yi5jIHwgNDEgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMzkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9m
cy9idHJmcy9zY3J1Yi5jIGIvZnMvYnRyZnMvc2NydWIuYw0KPiBpbmRleCBiM2FmYTYzNjU4MjMu
LjgyNDBiMjA1Njk5YyAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvc2NydWIuYw0KPiArKysgYi9m
cy9idHJmcy9zY3J1Yi5jDQo+IEBAIC02Nyw2ICs2Nyw3IEBAIHN0cnVjdCBzY3J1Yl9jdHg7DQo+
ICAgLyogUmVwcmVzZW50IG9uZSBzZWN0b3IgYW5kIGl0cyBuZWVkZWQgaW5mbyB0byB2ZXJpZnkg
dGhlIGNvbnRlbnQuICovDQo+ICAgc3RydWN0IHNjcnViX3NlY3Rvcl92ZXJpZmljYXRpb24gew0K
PiAgIAlib29sIGlzX21ldGFkYXRhOw0KPiArCWJvb2wgaXNfaW5saW5lOw0KPiAgIA0KPiAgIAl1
bmlvbiB7DQo+ICAgCQkvKg0KPiBAQCAtMTQ3OSw2ICsxNDgwLDM0IEBAIHN0YXRpYyBpbnQgc3lu
Y193cml0ZV9wb2ludGVyX2Zvcl96b25lZChzdHJ1Y3Qgc2NydWJfY3R4ICpzY3R4LCB1NjQgbG9n
aWNhbCwNCj4gICAJcmV0dXJuIHJldDsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgYm9vbCBleHRl
bnRfaXNfaW5saW5lKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLA0KPiArCQkJICAgICB1
NjQgZXh0ZW50X3N0YXJ0LCB1NjQgZXh0ZW50X2xlbikNCj4gK3sNCj4gKwlzdHJ1Y3QgYnRyZnNf
ZmlsZV9leHRlbnRfaXRlbSAqZWk7DQo+ICsJc3RydWN0IGV4dGVudF9idWZmZXIgKmxlYWY7DQo+
ICsJc3RydWN0IGJ0cmZzX3BhdGggKnBhdGg7DQo+ICsJc3RydWN0IGJ0cmZzX3Jvb3QgKmV4dGVu
dF9yb290ID0gYnRyZnNfZXh0ZW50X3Jvb3QoZnNfaW5mbywgZXh0ZW50X3N0YXJ0KTsNCj4gKwlp
bnQgcmV0Ow0KPiArCWJvb2wgaXNfaW5saW5lID0gZmFsc2U7DQo+ICsNCj4gKwlwYXRoID0gYnRy
ZnNfYWxsb2NfcGF0aCgpOw0KPiArCWlmICghcGF0aCkNCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiAr
DQo+ICsJcmV0ID0gYnRyZnNfbG9va3VwX2ZpbGVfZXh0ZW50KE5VTEwsIGV4dGVudF9yb290LCBw
YXRoLCBleHRlbnRfc3RhcnQsIGV4dGVudF9sZW4sIDApOw0KPiArCWlmIChyZXQgPCAwKQ0KPiAr
CQlnb3RvIG91dDsNCj4gKw0KPiArCWxlYWYgPSBwYXRoLT5ub2Rlc1swXTsNCj4gKwllaSA9IGJ0
cmZzX2l0ZW1fcHRyKGxlYWYsIHBhdGgtPnNsb3RzWzBdLCBzdHJ1Y3QgYnRyZnNfZmlsZV9leHRl
bnRfaXRlbSk7DQo+ICsJaWYgKGJ0cmZzX2ZpbGVfZXh0ZW50X3R5cGUobGVhZiwgZWkpID09IEJU
UkZTX0ZJTEVfRVhURU5UX0lOTElORSkNCj4gKwkJaXNfaW5saW5lID0gdHJ1ZTsNCj4gKw0KPiAr
IG91dDoNCj4gKwlidHJmc19mcmVlX3BhdGgocGF0aCk7DQo+ICsJcmV0dXJuIGlzX2lubGluZTsN
Cj4gK30NCj4gKw0KPiAgIHN0YXRpYyB2b2lkIGZpbGxfb25lX2V4dGVudF9pbmZvKHN0cnVjdCBi
dHJmc19mc19pbmZvICpmc19pbmZvLA0KPiAgIAkJCQkgc3RydWN0IHNjcnViX3N0cmlwZSAqc3Ry
aXBlLA0KPiAgIAkJCQkgdTY0IGV4dGVudF9zdGFydCwgdTY0IGV4dGVudF9sZW4sDQo+IEBAIC0x
NDk3LDYgKzE1MjYsOSBAQCBzdGF0aWMgdm9pZCBmaWxsX29uZV9leHRlbnRfaW5mbyhzdHJ1Y3Qg
YnRyZnNfZnNfaW5mbyAqZnNfaW5mbywNCj4gICAJCWlmIChleHRlbnRfZmxhZ3MgJiBCVFJGU19F
WFRFTlRfRkxBR19UUkVFX0JMT0NLKSB7DQo+ICAgCQkJc2VjdG9yLT5pc19tZXRhZGF0YSA9IHRy
dWU7DQo+ICAgCQkJc2VjdG9yLT5nZW5lcmF0aW9uID0gZXh0ZW50X2dlbjsNCj4gKwkJfSBlbHNl
IHsNCj4gKwkJCXNlY3Rvci0+aXNfaW5saW5lID0gZXh0ZW50X2lzX2lubGluZSgNCj4gKwkJCQlm
c19pbmZvLCBleHRlbnRfc3RhcnQsIGV4dGVudF9sZW4pOw0KPiAgIAkJfQ0KPiAgIAl9DQo+ICAg
fQ0KPiBAQCAtMTcwNCw4ICsxNzM2LDEzIEBAIHN0YXRpYyB2b2lkIHNjcnViX3N1Ym1pdF9leHRl
bnRfc2VjdG9yX3JlYWQoc3RydWN0IHNjcnViX2N0eCAqc2N0eCwNCj4gICAJCQkJCSAgICAgICZz
dHJpcGVfbGVuLCAmYmlvYywgJmlvX3N0cmlwZSwgJm1pcnJvcik7DQo+ICAgCQkJYnRyZnNfcHV0
X2Jpb2MoYmlvYyk7DQo+ICAgCQkJaWYgKGVyciA8IDApIHsNCj4gLQkJCQlzZXRfYml0KGksICZz
dHJpcGUtPmlvX2Vycm9yX2JpdG1hcCk7DQo+IC0JCQkJc2V0X2JpdChpLCAmc3RyaXBlLT5lcnJv
cl9iaXRtYXApOw0KPiArCQkJCXN0cnVjdCBzY3J1Yl9zZWN0b3JfdmVyaWZpY2F0aW9uICpzZWN0
b3IgPQ0KPiArCQkJCQkmc3RyaXBlLT5zZWN0b3JzW2ldOw0KPiArDQo+ICsJCQkJaWYgKCFzZWN0
b3ItPmlzX2lubGluZSkgew0KPiArCQkJCQlzZXRfYml0KGksICZzdHJpcGUtPmlvX2Vycm9yX2Jp
dG1hcCk7DQo+ICsJCQkJCXNldF9iaXQoaSwgJnN0cmlwZS0+ZXJyb3JfYml0bWFwKTsNCj4gKwkJ
CQl9DQo+ICAgCQkJCWNvbnRpbnVlOw0KPiAgIAkJCX0NCj4gICANCg0K

