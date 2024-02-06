Return-Path: <linux-btrfs+bounces-2148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C558A84AFA7
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 09:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFD48B24AC5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 08:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3C712AAD9;
	Tue,  6 Feb 2024 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xr0oD3SP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mKPhMdKS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C60129A77
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207022; cv=fail; b=p02RoQ71AueLwq+n9hwh6nZUv++eJWql/N+S+vda/Dz1V+WeLk1x9vAsCEDtRKY6jDCI8JLjUR9eMP4q/txq2GeHuPmOikc9U9dSZfSGtOgdq6SBD4Uclecz1p9HRXaVI3GjqNOmywXSZvHtww0NZWpGE0X/Kl0l36wxmUws8Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207022; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WN252QzkK5ZI3FtKazOE3wkI7n+fLYAITRsHcDG54Z04ioIc9Ws4H6F6TqPli3qhHwsTo94N3NXJxGzBDEul0PYnRUAHdzA6qOV58lVnD1VZ22EBilMoEfdLdNajncRvEQKDc5EndKVWEeMfNZ3CZjY3+1w54p5ajb2Yt9DHxKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Xr0oD3SP; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mKPhMdKS; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707207019; x=1738743019;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=Xr0oD3SPSAiPbSNl64ZwLVlzCsEj0x3oXN1Wx304JeMJc8qx7tlVwG+v
   D82a9lDziWunn8pbObeU/MHWfjBitnW0gRMBLJKdmGbJQtrEIHXVOUX5+
   x4lrDcQfHqaXmfCbcS602lY1jzy67OxsGj42S57ctWCL9PYk7aV3A7be4
   KKEj4zyYXsC6j+JO6q0CuAqY9r5bPJcwz7fCIq5dG8kSkAJtDjQB44Hoj
   TQjzunb2O8BfYKYivv8siKoTB1Hts5sYCFGesa+HdPYOVP929h9fupKMi
   tC488AzHnXee5flG5oBIhV/wXQ9HYkT92KPJK3Q85QnSgmbXO6nmM74nH
   g==;
X-CSE-ConnectionGUID: VrS/uWsJRkyTYtyb4P4DcQ==
X-CSE-MsgGUID: pGgJL7+wQYujEBh53wlJGw==
X-IronPort-AV: E=Sophos;i="6.05,246,1701100800"; 
   d="scan'208";a="8596020"
Received: from mail-southcentralusazlp17011010.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.10])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2024 16:10:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbV4pGXmAXMdVnFmECJ1NKTNeAEl+ogS1Kue9CaT1mZD9hpHmdk4+u1cCM7avbP1aFP4Wyt/ywrbUJdoPu2awzknOP3Q4qEgfKMDUc9Py0Lc9NajSBYGr3dowQmthy6j6qGDONXPP6msyUO9tqgFoGAslKgkA5MmJ5UxxgoLybyxIyrLzCaLLjgBaiOkGaQAte4yJd8SEheIh32aIvrdUrjIbgb4CP6QuC+n/r3GGvc3I3c9dQ5wpyuGL9W7dJV/ny0LEezZDBjl5xHcsrG5aak0a1dvPZSiieaDzU8pQMmDIaflEFIZy41w105hmuF70dxBfutYq4P3Bw1wA0/mCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=jHgeBDRB5+AU52j7rHp3Ev66UQ4/TWu7T3doQHUDrSQIWTqjvdYYe3GAERHVRSixso7pEjuMyUzj1KYrJ6dEYW9I3cJoa7fd4jCEckXEJ0tZir1E78V2Oopxdy4vz57WfOYT34OiXsrzgLLQEknTAwmCMJi7cIRDdHpPdBEwvJssV/x9gERcxh7a77attABeM6TrwCRGQSnMC04ml7QZX4bIqOha5O194EmkqqK0oOdb0aYelZ5oGB6DCLIuhy8sRuYp/tGE45okHFpFA7LkQVeatkVq8x3Owtpy+qDjvDsmnEqo2YU/jMht0Zm0oCF4s9ZcKsqrpJjl6SbKk3XINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=mKPhMdKSQDZnf6RUvwV0IqtnVyiUtJwSC5/zDX5feL28tcz0GwHPh3lLgvG6kY+VyeY0zZqcmt4YC5Yos8J2TCWjnCSROMSXMXj5K8eGB8iuwbDwGwUvwh+z00A081+0ex9Hb+haHalEV3aXJ9kSul6ljulZPa+vL1Jg4xMv0hQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6867.namprd04.prod.outlook.com (2603:10b6:a03:22c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 08:10:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 08:10:10 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "wangyugui@e16-tech.com" <wangyugui@e16-tech.com>, "clm@meta.com"
	<clm@meta.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v3] btrfs: introduce offload_csum_mode to tweak checksum
 offloading behavior
Thread-Topic: [PATCH v3] btrfs: introduce offload_csum_mode to tweak checksum
 offloading behavior
Thread-Index: AQHaWDPCnIKBS49GO0S8rkzQX1iSj7D892YA
Date: Tue, 6 Feb 2024 08:10:10 +0000
Message-ID: <98cf17d2-a672-4ac5-8c5e-b6489c1f3f59@wdc.com>
References:
 <8dc4a312da70bb93f042f32a75efb7ec848cc08b.1707122589.git.naohiro.aota@wdc.com>
In-Reply-To:
 <8dc4a312da70bb93f042f32a75efb7ec848cc08b.1707122589.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6867:EE_
x-ms-office365-filtering-correlation-id: 21eb3cf0-14c3-4013-fafb-08dc26eb0a07
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 u9vSGtgHkOU48rnJkDaxs6TqBY2Z6295ufK4lWUwLgzWzzPjpIzTyhdtQVapb9NRz9/a19SrD2sJX6C2CbfVeP+a8Bv9b9WbriXHB9A3uU5PfqXnGJ8gJOoR4ysDehd0mywW6rnfq1jzCZ7V96PDQNNf0eFgT+h5KX/A/E0q6n2bbAQ5ALh9rffkGCtzksYvymXI86Ex0TcKa78z5Y7WimVh551pCy9qrrwFtWhx0k0x9nQbv+5Rt9MZxvH4uVrJMBDPcTCCgdm6hwjI6bOZZVa1/75wv8ZuKtW38Tgrn3ct4CKDvcg97K3AAgC+/hOyUrIXtPLrW0l2Qj4CQieoYe1HlodkxRbsB8UZ7YRtAVZ1ihjEXV4VfO8atSHUKn2JVZdMVBX0x8IhsLWkct/1xDwU3pwQZpC8nP/b3O63aLk9pioEgDB7rkmE7thvAiXqeCL1AADPIzx2/l8uKQKYBnZ0DzXsPwI+WqNkk1EEbZn84pochlvVm2p8oXC/GoHd7Wsk5/5on0T4cX8eH3FvZNhAiVtYe8B+/LcxROeCpklXrRgBFi7fr2vlWLaRGea2Zjbu69f0ox1wcGjb6PysBXbkUF9LLT53wZ8IluoqNEWVq8PNHs6Du+8MhvAKxDum117BK4QtYyb4+tJcPJbZ85CIy1O9AJ8ds37dOFhM6LKjGuSBjXOjfZYpTWPVMqPY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(110136005)(38070700009)(64756008)(66476007)(76116006)(66946007)(66446008)(66556008)(36756003)(316002)(54906003)(5660300002)(8936002)(19618925003)(4326008)(8676002)(2906002)(82960400001)(38100700002)(122000001)(31686004)(4270600006)(558084003)(6512007)(71200400001)(6486002)(6506007)(86362001)(26005)(478600001)(31696002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWhJNWlzQTNtc0tkbCt0RFhPYmZ3c0ExUmpvcmNyOVdwbmNnclFxS2FjMS9t?=
 =?utf-8?B?ZmIyb1VyMlJqd3AwNDRkSjVDcVZxM3lCWmFZNVhUaXhic0k1dzY0RmJFejRy?=
 =?utf-8?B?elNrQzhEc2RtODhMNTkydEl4K09qeEU5cXJlL2hLK1lKS3VtbXpNYXZlNXRa?=
 =?utf-8?B?NlJZL0pubmdYMEdHbDFXWFdGMjhPM2JMTHBnUE1zVGRwTFJtd0owZHU4UkFV?=
 =?utf-8?B?UjVkVjROSVVPOTJFd2xTOGxGaEIyVUQ4NWdjMGV3bG4xU3lEbE90a1RWTXNO?=
 =?utf-8?B?QkdLM3ZDQjN6MDdkcTlkckFXQjgwUUV1TTdTdmN1RitWSktIbkhMV3RhQmpU?=
 =?utf-8?B?Y3oyaGJrUndDVk5OVkhyVmZJZUM3SDhueUhWMHlDaVdkWTl2TVgzU0RBRnpr?=
 =?utf-8?B?MitTa0VYN054UjUraTV4eWRNcnpXc3NIbnB5dkVja2cwaHloemZ5SGtzZ1J3?=
 =?utf-8?B?TmNRMHFzVCt2SEtmbTNUNkQ2UHdSTEZOQ24rL0ZjWG50Y1NTalhubDlGN2ZR?=
 =?utf-8?B?V3NmQW5UK1ZodlRxTUZkb2c3cGdZQ0IrejhHVlcrYlkvUmllQUczcEM2WTFW?=
 =?utf-8?B?OHNYZW9ZT0sxMk0wWExvbVpxU2Z1ZXAvb2J1Smd1NktqdlFXbXdTRU5xYnNz?=
 =?utf-8?B?cEkzNjBmbmkvREQwOUxoNDFReUNicWQvd0dsMG55UWlibVg0MlBtRDg2dTVD?=
 =?utf-8?B?VVc4UG5EQkNoSGxXcHdNSmYrS3NwamordmFCYVdsckFnek54ZENQRnh6dkY0?=
 =?utf-8?B?YnVmc0R6eWlkZDVYbStKM2t2aHNmTm9CL2lBZzJaMUYzOWNid0l5eTdMeURT?=
 =?utf-8?B?cEh5cjl5S0F1aHFyNWxUQkljQmdTd2RnelduUlNDUnhFaFRDNlllYjBpeHNw?=
 =?utf-8?B?Z21QYmd6SzQ4aWFYdXF1ZE95cURlUkt2WmdsNWorUUJPbnVYMEgxZzk5S2Q4?=
 =?utf-8?B?ekFFUFdVSTkrT0M4WXVFekxCK3hIQ1EwQ2pmTU51UXNDS2N2TDlWM0E5dmZP?=
 =?utf-8?B?alNSZW1IU0VsNVVnM2Y0eTR2MXpwMTM1cStDY1d1eFZzeS9KOHlHelBITStC?=
 =?utf-8?B?cFpINGc5cEhrejg3ZnB0YUpKWVVPaFdNT2xhYkx4K3h5SFZ3azh6NDBhTm83?=
 =?utf-8?B?blp5N2ZsSWhYMXM3Q2dYcXRXOUJ3RG1TUU5NSytrTFpxSnowOVBPT3h0V0NE?=
 =?utf-8?B?QjUrWjVTVUlFQnhwUU85cnNoWG4vL0Q5TSs2cXJzeURuSmI0UG1vbmV4dE56?=
 =?utf-8?B?c3FXcFpESnlvUXovUFQzZXo4RTBmeTNsay9FMnFVbE1FMkp1MWczV3FDaXFT?=
 =?utf-8?B?S1NDWnRmeG5MK21jc2R5UExwdHMyRkEzZXFsQkl5T05uRm5nU3p2MUlLZXlu?=
 =?utf-8?B?Z3gvVXR6STQ4TTF3ZFBGc1U2REFDM0RSNUtXbUhhMlQvTmpJZG9sUWpROEFP?=
 =?utf-8?B?Z293dkdleXBuNi90VzlrRlhIOWh1UlBIaTZaS2pnWjExc0hMNGEzWHdJRTBo?=
 =?utf-8?B?bS8rWlQ1NUh6VWQ3d0xtY0pkUnR2OXYwYnBwS3VUOW5aNWNIcXBzeU1RVlA3?=
 =?utf-8?B?UnJWanc2UlprMXR0TlJ6cUtJSTl4VmhwQkVLNE5OSmpnODN3M1hGS2JMbVZ6?=
 =?utf-8?B?eWIrbzVRMFlIR3hMVVJydWpkTlBRbDRoWW9XcVExbU11dFFTVlJRVXNjZnZw?=
 =?utf-8?B?SEJPTjhHYXVKM2JoWjZiaVJiN3pxUUMzL0xWdVN5SkNNTks0aDBiODZaL3Qw?=
 =?utf-8?B?R1hPMXF6ZkJycTdpeG9LUS85VkZjcTJ2OTdCMEcwVVhiTXZuWERhZS9GODNG?=
 =?utf-8?B?R3ZoeTlHWFNFb2ZrTm5DYUo3OEJyWWxJNGNZRHFpUUdoTUNHTDlqNm5BcGhV?=
 =?utf-8?B?OGthc2pIWXVWaUhmV1l5RFluY05zQ3NvTUZLbWFRUzdqY204WXNoR2JSNU5K?=
 =?utf-8?B?Qkl5cGF3SlJtK0lqaEJTdWhsQStoOE9XNXdESm1ldHNWMHZ3MGx6eGZieGlR?=
 =?utf-8?B?WVVSMnRYVmpvbDlDVW9JVEVuWDZTalRNWEZyTFdYcjdsTEZNYjhwcEpkUUtW?=
 =?utf-8?B?MHFENEkzbjd4OWhVNW1nSVd6MTQ5dkZ5bm1QYlpDaEx5MWxkMkxPaGl2bkFu?=
 =?utf-8?B?V3dtak9xeE9WY0YvVjczWXdabXUwUnJQM0xhMXRLVnQyOStvSjlidVh5MDZN?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <945AD95CB47E5843AD0FC2E493D1C041@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n8JzGFbjcRfGbDnACTh+z93Dw0j/UT2aWJ7u9P0/eMXssujXzIlIpM5VWJbbTyhJq61exkFFrdmS+zHhLBxigla9pRjt9CNGm6WOjl9uEYdOj8J1NtK2IGZgNXHznGatm1ciAr6SPt2gu0nNYo/n3FdCuZbo2WqqN6Lfhn7bztnMv0PMXHdhMTih2ps0CPvMAumcLb/ocPa1BV5NW31MVQdgkZ5CILalvrgdJ7GzJlnDvbFpHqY4lKIUog3z4rUhXYlW4Nz/fSGZud1f+Tobiqdd1199sKE7Wv2KRhf/ip11LXnCaPUt4bZnrd0LTkkpza2slL5jG8H5uSCvupp7sqCQzl6wSE47Cf300XZvHJKcAfrc8FEYycxU8gjlWsReVOIllHfMKLbBeopyxnBXn+YlglVhrzv6GNU4D85QcrFK7ucBMwt/ojkxKSUnYhBQAWElH20dnKKPMjckEBebhorWO748q2nK/aF1p3ALSXIQ3Oqe8qjmZZbFRq/lM+LrsM59CpNqW3oFULiYZZlW/yZA9mGx5RZffqxfTfP9RSVVlMDfpgsfi48JTbT3/I0hLlYflgbFjU6bWj4ekWEPsNYJwQvngzTER5Z9NV1qmyHCJk4/kUhJgZ32DuVSfcFm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21eb3cf0-14c3-4013-fafb-08dc26eb0a07
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 08:10:10.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6r+Igh2zuQkA7/4YskmTBsI77hiSvVLUt7egPXUe5GvWalf+tqeL2xP+EmwGNvrFglBjufPJEGv85kIQee7E0aX7qnnyI4QJIMFYhPe40g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6867

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

