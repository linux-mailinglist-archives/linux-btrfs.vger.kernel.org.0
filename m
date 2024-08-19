Return-Path: <linux-btrfs+bounces-7314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8507B956576
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 10:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056201F2220E
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 08:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1AD157A67;
	Mon, 19 Aug 2024 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NSvVIPU+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZoVq0kpI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CE6182B3;
	Mon, 19 Aug 2024 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055784; cv=fail; b=giyZlq6NFZmh+lzq5yHN0t7QY0+Fa3oGsQ8rcnMeh//J2/Ot1gu7Mvy1nlv61VglbysvG206+6sJ7IIwfzxJBEizr/+/fZzXJ1YJp5bAmoUKldAAKIqpU70P2LvkwhHW3eWb46MFDXr/dNsT0FdKByd1EmXgDOOZV5IpbeQQk8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055784; c=relaxed/simple;
	bh=Zkm37SWsRdaTm6QJmDFLL0v5ran/Xx6esnqKOT7DFOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J92PXurFr0Sg6HthzYi++8GNabg2LzCejEc3OL8Geu7L/kf6p8JM7tLTAVw6FMKaJhRDM1NqycxHdf0fXC1ZIUWGsBdLB323E/4biU2vI4F2NodmAZihObGfLJ3VClPAM/5lN5UOkBQHDX7vW3hOuLUjw6mufCW0AHAxoFvHewg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NSvVIPU+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZoVq0kpI; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724055782; x=1755591782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zkm37SWsRdaTm6QJmDFLL0v5ran/Xx6esnqKOT7DFOc=;
  b=NSvVIPU++PAN0O/5xnr0Wr/t/yEIsVkBHm0P/iQuisf9IWa+K+5EcOkD
   33m0ztOPHoSAZRgULY7iy4qsRlZbsFqjjnOZwBLJDd8ZtXBSkN7o9MP2z
   Y6YBiDVlxR1igsE1crstQRjoxpxOYXCVD5uAqvguchCEBwsF0tSX1YT5v
   LibPDg9gT2RFRovz21naaKtu7ZrPTMrp91IgQqvhUO4uoMV66oMboJ18M
   0QQ6E/OXqXt09pSxMuerW4tAFheni0271laLIkFl/MeGcj916Yzew50b/
   Ah6527ONVzMUH3Khd+RePIWUlxbysqW0woqDQHCWJpPXTrCghq85IQRiz
   Q==;
X-CSE-ConnectionGUID: 993ROhcnSjqudyNFy3D6vw==
X-CSE-MsgGUID: WP8Zuv23QO6ls4d9L5kW5A==
X-IronPort-AV: E=Sophos;i="6.10,158,1719849600"; 
   d="scan'208";a="23999246"
Received: from mail-northcentralusazlp17010004.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.4])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2024 16:22:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGA140vvSOMroQhrDWP6CgIeVaxFKDpXhZtJzL7VcIcgSmVvJmu8f2vR6aiJHAVw7D/LbYiUv/xTiOUjyjyW3jXUrjmbJpS8OyFbknpE3GMnWbQmvZReTTQ5LpDtciJqa2SeQUfNaEvIdcOSBJf/A7obgxJR+sZHcReivSDgK+N9ymkXRRLVCkOGpF8bP6AVTSD3Mw+nw9aL0K6eD68EHCHYQDJ07/30tkweti/I4DJzDQyo/Dcm2gPOBrDu9tiaGFbxS3roB2qwkc9Rne2NAPFlIpq0w0iz61Qx+KzgwdGnrVAPzj4WSzC9LwoE2XDaVpsv2TMaqMqY1EhJdwJsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zkm37SWsRdaTm6QJmDFLL0v5ran/Xx6esnqKOT7DFOc=;
 b=GJpfoqOJaM8VCc1liqXU4RvMzdbckbu0ZFbOGEcUyrfw9hFNCzs3kGe4VQRO68Cx8gE4aknFfIqzzS11TsoDFmMpih0dukb3wG88EvRMuGOyZKfuQS8ajSFj4aWgoJSZh4NyQyvLyEBBPxL1JuFqnl1A+bqosn8DKX3yD3dyYN5Yat/itsfu8g1Wd//uGkXRCaIg4ewRa4okdi01aA0aSmpldKGbP81gR9EmToTXYfLUmRTMKZoKys/rnq+zltjzbt1oq39wn4RlctvZeffZmiUe/7B8+uPfJ9zynNoaZw9w1NBWUVu0AYu9hNRFc1blpW/XYDtq+fgwVtnArLz4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zkm37SWsRdaTm6QJmDFLL0v5ran/Xx6esnqKOT7DFOc=;
 b=ZoVq0kpIKExke88pnAIsT7VfCz9PzIRxaT3S8qQMS3YIro6zVAEmNrjdLvIWbnK0dl6YoK73NNCE9LuBwXpUzsbd9gFzHlX9SPkw2VY+4Tt9kl2Tuk5dz8uzqi25vVTB/OHyxzSXO1b0VDtlk7LeZWvurUuj21bZ/qm9kWIEPyI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7664.namprd04.prod.outlook.com (2603:10b6:a03:32c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 08:22:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 08:22:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "open list:BTRFS FILE SYSTEM"
	<linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: don't take dev_replace rwsem on task already
 holding it
Thread-Topic: [PATCH] btrfs: don't take dev_replace rwsem on task already
 holding it
Thread-Index: AQHa7xK0aGvyiSoY206iqCX1Gh7qQrIooK2AgAWjJQA=
Date: Mon, 19 Aug 2024 08:22:52 +0000
Message-ID: <722f7cde-9808-482e-8538-5b70eb7ba40b@wdc.com>
References:
 <9e26957661751f7697220d978a9a7f927d0ec378.1723726582.git.jth@kernel.org>
 <20240815181739.GE25962@twin.jikos.cz>
In-Reply-To: <20240815181739.GE25962@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7664:EE_
x-ms-office365-filtering-correlation-id: 3bd149a6-a074-4e6e-cac3-08dcc0281e90
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y1JaT3kxajVMcHlCc012MmVRUjZDdmVJQ3RjbDRKZXc3Mm9FNUIzVzREV054?=
 =?utf-8?B?Sms1RmpzOGhiZHlKaEZZRHpRL29JVkZGOG4xUDI0YnhsdkFyYTI5ZkM0Zmd0?=
 =?utf-8?B?SmZvWXFsa2dabGN1eEVCQlhrcWRxRVFmaTdLaTF5NW9NMmVaVzFYVGxQYWVh?=
 =?utf-8?B?RmpMK015MlVNYi9yWEp0RmlHUFRqd213ZEYzTWpxL0xwdGVmTmMyM2p0ZzQ5?=
 =?utf-8?B?S2ErS3JNQmRIRHMrQmlYOGFGdGtJWU9yZ2RaTGVIT24wZ0ZDSVEvUXdiU1Vj?=
 =?utf-8?B?UzhJNlpxUWlhdWRmajZteW51YkVYY3NSejdGRjM1RmRnYUpSMFpXblBuQTZX?=
 =?utf-8?B?eVFUV0pJd2Z2elRNNDZnSkpiYkFCSklPYjFQcWlsZ1c0VWtZM1ZMcDlmQ3li?=
 =?utf-8?B?M0E1cEdhS2JjQVJtY3NoV09tWDJGMjNLaFhRbUk3RzhOM1JBWGJyS1lQd1RF?=
 =?utf-8?B?SkJvNmJJeXZqeGtKazIwbUVIQXFTTDNUSm8yL0dnMHVmZk1UL1VndHA2WmVJ?=
 =?utf-8?B?TkVDd21TNEVSNmhyYXFLeDB0QnJHdGMrN0l1a3pyWEVPb05ET0VsdzE2YStq?=
 =?utf-8?B?VHd4OHpWcHdRMTgwZjd1K00xdTR6b0Jmc2ZZUGZGZ1NzZzRqR0FLK2Vqdmg2?=
 =?utf-8?B?RjNrSXI1RlVxWFdIV25BRlJzZ2J4NDRzSWZvcm5OK1UvS0Z6TDhwM1VpUGk5?=
 =?utf-8?B?ZGNkWVJ1SWFXazE1Z09oREhTVkZhQ3huclVoUStKemFxTUI4ZTZiZGd1VW45?=
 =?utf-8?B?a1ZaRWd6TVhyVmZxaEE4cUYrMmxjTWYvN25RK3ZtQXh5T0JoaWRrMlpJb1lo?=
 =?utf-8?B?MUdQYTVsMGY2RzZaYytwcmdxY0J3cGV2cFNZK24zcC9yaEZQV0V4Y1hYblp2?=
 =?utf-8?B?YTVtOXhzbndtZkpsS1RSYWx3V0wzVHh5aDZYVXk1MThNMUVySWVVZXljVDFZ?=
 =?utf-8?B?NVZHYUN4Y1poYmIraFZRRjUrZnhoWGpjc28xY2hXVjlQTEw5ckxzMzdNckZD?=
 =?utf-8?B?N3dqV3hRV3NGT200bXdBeGMwQWROS3kzaFVPYVlYSCtuZGhBSE1OaFdmTkQ3?=
 =?utf-8?B?VUphOHFheDRsQTBzYjNWa2J1TXRLRVhXK0hpSXNYZ3ZpZkd6cXcxZ3UzL09N?=
 =?utf-8?B?QzhyRk1iUWMwVDdqT2NmY2FsOVhkUFY3ZWFURVp3dEo3UXdiM1pSTy9obGFa?=
 =?utf-8?B?b2JaQ3lraWhxTEpNL015bUlUcG5HUXNYeEdZdDZwYThYTEd3V3FtaGtESUIx?=
 =?utf-8?B?UVlSVDRGSDVaQy80OWh5ZU5JSFhVcFJXMXd0cjAvVGgxaUc5U3ZaL1ZteFBo?=
 =?utf-8?B?ZkxuaGtGbVVGZXZPdlpEaExNdkhBMGlQcEpVblRzMW5QaGhjUFBtT3ZaaTRV?=
 =?utf-8?B?TDdZZXNvUUVDUU8vYVZwTElFb0xmUWZIVmQ3M2FBT28yR2IzVUtUbFZwRmcv?=
 =?utf-8?B?MThMZzR6d1R4QWk2OVVFV2x2alpSU2FkQ3A4RSthazBWcm9vWDVsbzFoNG4w?=
 =?utf-8?B?SEVrL2VEMm5PN3l6RmtFSzhUTlMvOWwvcVhrMTBmNENJTUtVVkVnWU1zVlZt?=
 =?utf-8?B?Z3dZSEJyb3lNRHliVDByWlJwTTh5QXNXWFl6NVUxYU85WmNkZStKQ2JCcHhF?=
 =?utf-8?B?Q1l3aDNRanVIbTFXN0ozZHJ1MFp0RFJPLzA0K1AzWHFIQkU1RVNVaCtJcnZl?=
 =?utf-8?B?QXc3S1RrUzNDTi90Rm9YR0R2UkkwNjAxK0VuZUFkczNUK2tEOGRrcTNLM1o4?=
 =?utf-8?B?VDVDNkY1aDAzeXlSWnJiT01CYlhSSzZrWGt0TWQyR1pGOTBSSThiOWs0TTBl?=
 =?utf-8?B?OE43LzFZUXRWamVpMkV4czRGRm5DUkV0Tk5icUsxaTU4T1c4cmxUZFJkNFlB?=
 =?utf-8?B?K1hJVlNrWWVJZElDQjR3cWkvWGpvb2IzbHZkbE1CbDk1QVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGJYTTVEdEFWZHM4NlFCa2U5WkZJL0Y2YmVhQXc4SzFOa1hwSzh4ZHh1SVBn?=
 =?utf-8?B?M2lJYnMycW15NnVkS0dobWNSa0k0UDNoNkZnM1A1Q2dVK0xGU0NqSlhUREN6?=
 =?utf-8?B?dTJIVlcwcXN6UWRqbWIvNnR4dHBSa05idW44ZGxoOE0rVXMrV2JDcUJaK0l5?=
 =?utf-8?B?Q29ub3ZTOFg2TEtEV21QdGhRNFo4d1ZzUUdRdUR6eWRINWRaR1VwWThEdk9X?=
 =?utf-8?B?Y1RteGI5aGhNc1IyVWhReXdOWktRTGk5MDBWRW0zWWhGZ0JKSjNjd0FRUHRn?=
 =?utf-8?B?Z1Y3N0FEUVRsMTAyaTc4YUN4Yy9DWmw3TFYrZzFrWGxIOG5VZkdOenJCd2R4?=
 =?utf-8?B?cVgyWHovdUN4akNmc2ZYZVFyUE9jeERCbForbVJhdVQ2eGRlWkhSMzJveVhl?=
 =?utf-8?B?VWVNVEQ2M25TdHduaU5LSy91M3FzN2c1YWNTMWp5VFlva0V6VFpxV2tpY2JE?=
 =?utf-8?B?dU9vSnUzWkJ2TG5TTkczQUNmWUNXdmRJV1pCN3I1NE8rS20yZExvandJanNk?=
 =?utf-8?B?a0FUVWo3SmdIamEzMXh1TXJrUzFndFlxK29hZTFZT0VUYVZGTnFWZmZqZXpM?=
 =?utf-8?B?VGxUZ1kxMFZLV1Q2cncyU1B6YjJzOWVkM3dTUFRZM2t2a0xHOUphR2xWMnBm?=
 =?utf-8?B?UG9QRno4ZnFhd3FjRjhnV211dWJqZGZLL2FlZmVxaldJazFZS3FFbzVjdEJt?=
 =?utf-8?B?QUJaK0o4WU5Sa2I2U2tsS2NCNkRBTHRub2FPYXVrN1JnekxEK2N1b1RtdkNa?=
 =?utf-8?B?dFNCSUc2b2V6TXViUzJ2eHcwUUEvSDlVQTA5ckdEbW9Bd1dxS0FZMDhjSUIv?=
 =?utf-8?B?ZVJJcGVrSTVvbW96NjF0NlRzL0NtdFFkZmduSk9oRldZeWlCQTIzQzZtVkYy?=
 =?utf-8?B?emlmYkV6dHdneTNLTklMT29rOVZIT2UydW1pWk5KaGZwcFhpNjNrOEpaR1My?=
 =?utf-8?B?YVl1WXdudnFHZ2kzUzVTSnNmVVV5VDR2TUtPay9lS2hPdEZwdnA5RTJUL0F6?=
 =?utf-8?B?d25tb3Byd3NvcFM0d0JWd0RIRDBZalpWODZNQ092cUpOOHRxZDFoODJMVGhZ?=
 =?utf-8?B?ME1FejYxMUFNOENqSlc4NjZ3Q0l3bjFHNUdDbGFnbG11eEJzZUhiSUVJc3hF?=
 =?utf-8?B?TE00RlczanVmUlhqOWFUTmlmZ21PMnNVamx3MEx2SFdERGN6dU9MOWhzM2gr?=
 =?utf-8?B?OG5BajBsblNZSDArMWZDUGJBN1hQeDZuL2pPaUNVM1AvQWV1d0Yyd3dGZUtE?=
 =?utf-8?B?aDRXM3V4eTY2VU5yRHVyRlkvaDZPOU82emRjT0toOGx6OEsxcm1oenFweHZr?=
 =?utf-8?B?bUlTZm5tTVNxRVNGRFhtY1pONFp2bG5Qcmx1citYeDJaMy93Y08vcmg4ellJ?=
 =?utf-8?B?RGFaMi9nTEs2dUlmb2FjNFY3bDduY3RsTkQybmh0a1VJSUhyNUpLK05qVXlF?=
 =?utf-8?B?ODF1cnZyalg5SjBQNXpZdzdvdlZldWoxdmRpS3dIYmhvcUl2SElrNlF5S0cx?=
 =?utf-8?B?cXh6bEhlRUdNbU5KSFIvLy8vODF3aUhXWTJ4SFJHQ2NpclA2UnFVSHVST1A1?=
 =?utf-8?B?eVBiMDR2UUEyc3pPb0lCZENlOGRHMUtqRDA1Y0NSeXFvNW5TZndpZHlxSG9R?=
 =?utf-8?B?SkJNWnlYaHF2aVp2K3p6aWt2Z2JQNDFLT28xTnAzRU44bnhuMFdlTElpN05I?=
 =?utf-8?B?ZXdlcUd2ZDFiSlVvdUpUT2pKN21mbkhNQUZLMUd5bS94ZzdxVE56SkQzZEF2?=
 =?utf-8?B?cDdDeElzb1pNK1JNUi9qbUtNbjJwTldqRjFsNStBcFFIdjJudkwybjJiT1RJ?=
 =?utf-8?B?eGpSUW1ZWlRkekJJQU1PRGVvN2kwdHlTMzIyT3A3U0RWZGl0Z2JuaTJrbjRN?=
 =?utf-8?B?UWtQNVo4UUltMTB3SVJMMkx3WmFSdkF3YWYrOTVNRUsxVzJrZGpiWGEyd3cr?=
 =?utf-8?B?eXdMWTBHbUtGT2pOeEhla1E2NHFIU0NlSGp2MnJDVEErNGx3RkZadStoNlNw?=
 =?utf-8?B?TjdiY1puaklOTS9rUlU1YlVwa3k5NWJ3VTVPS2huQVhlbTRhZTlHN2Jaa2Zq?=
 =?utf-8?B?NUY4QytUNlppd1VEU09PcmJMVVNxSmprR1pUR0lHZEJjbGg5eURLQml6WE52?=
 =?utf-8?B?aGdFQ3JmL2xwZENNOEdSQm85aHFLNERVRE92c2g3WXlXQTN2MDBkc082alpB?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4285B541B39F4F48B7BB84D2B53413EA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+JeX2PQ1t7M01PLLpfAG6oyVNxD/4LakZ0kr9UQeIhxGjP8QqOrbDgD1I+r692Ir6QiKvvuEA4SRj9Ykk9vVcBNzlwbFiqteOBygH6tfjNYPkMwfWg7/BbrKQXe5Du8SafZ79yT9hWqskESSYGxEZhY8Kh0XdsFuG3KVc5QXBOofVlju+dtGrtp+rCbgEi61zpK7/QGjZepqoo5v1kMa2350sreWfgqtvBilCYjYqDHySoKBt1jLgHs9t6TjnKVGMGyJ/TwTwX4DezUbdCj3pIAjpeUjT1Ndac2AiGKFJnIJ667dI0katDRT1AgJmvT1EaW5rKzoz3md2fFtzb8EuROWXXwHtnJTl32DJyJdl28BrAiRNyQZGcqCHGgeBBdnvLQzuP9LbW2NpvyaPhYfAtuWucaf0Y62O7S5s/ukqzke7LVkBZlXa89IunAVT0NfNuXgojmGnTvGdW9Y0rOSmetyLrNVE4gdO7pZHOlPFGj7EBwYSkvAdG/j2SEzU3jqk1LKlyXJMHZIAcoFlO17PfFz5Dw6z0gk4VUa3uZitQmdh6SFqOUv0PFHgtHBuM+5x1V3VacSEVr2wNhJSLpOXakNR+Uk2J4vny7cAM1DHlCYRqt+M4HRhzrKv8Y+AE07
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd149a6-a074-4e6e-cac3-08dcc0281e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 08:22:52.3440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGNjqL1p3QbL81iXC6e1DJq7vtx7iNE4EITGycuCjQnT+LPl/rdSwGvr+hi0TAJfetuF5wgIDfjiZZfo6Zfi7L6lOhgv2+JjGjXMkTjS03Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7664

T24gMTUuMDguMjQgMjA6MTgsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gT24gVGh1LCBBdWcgMTUs
IDIwMjQgYXQgMDI6NTc6MDVQTSArMDIwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4g
RnJvbTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+
DQo+PiBSdW5uaW5nIGZzdGVzdHMgYnRyZnMvMDExIHdpdGggTUtGU19PUFRJT05TPSItTyByc3Qi
IHRvIGZvcmNlIHRoZSB1c2FnZSBvZg0KPj4gdGhlIFJBSUQgc3RyaXBlLXRyZWUsIHdlIGdldCB0
aGUgZm9sbG93aW5nIHNwbGF0IGZyb20gbG9ja2RlcDoNCj4+DQo+PiAgIEJUUkZTIGluZm8gKGRl
dmljZSBzZGQpOiBkZXZfcmVwbGFjZSBmcm9tIC9kZXYvc2RkIChkZXZpZCAxKSB0byAvZGV2L3Nk
YiBzdGFydGVkDQo+Pg0KPj4gICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KPj4gICBXQVJOSU5HOiBwb3NzaWJsZSByZWN1cnNpdmUgbG9ja2luZyBkZXRlY3Rl
ZA0KPj4gICA2LjExLjAtcmMzLWJ0cmZzLWZvci1uZXh0ICM1OTkgTm90IHRhaW50ZWQNCj4+ICAg
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgYnRyZnMv
MjMyNiBpcyB0cnlpbmcgdG8gYWNxdWlyZSBsb2NrOg0KPj4gICBmZmZmODg4MTBmMjE1Yzk4ICgm
ZnNfaW5mby0+ZGV2X3JlcGxhY2UucndzZW0peysrKyt9LXszOjN9LCBhdDogYnRyZnNfbWFwX2Js
b2NrKzB4MzlmLzB4MjI1MA0KPj4NCj4+ICAgYnV0IHRhc2sgaXMgYWxyZWFkeSBob2xkaW5nIGxv
Y2s6DQo+PiAgIGZmZmY4ODgxMGYyMTVjOTggKCZmc19pbmZvLT5kZXZfcmVwbGFjZS5yd3NlbSl7
KysrK30tezM6M30sIGF0OiBidHJmc19tYXBfYmxvY2srMHgzOWYvMHgyMjUwDQo+Pg0KPj4gICBv
dGhlciBpbmZvIHRoYXQgbWlnaHQgaGVscCB1cyBkZWJ1ZyB0aGlzOg0KPj4gICAgUG9zc2libGUg
dW5zYWZlIGxvY2tpbmcgc2NlbmFyaW86DQo+Pg0KPj4gICAgICAgICAgQ1BVMA0KPj4gICAgICAg
ICAgLS0tLQ0KPj4gICAgIGxvY2soJmZzX2luZm8tPmRldl9yZXBsYWNlLnJ3c2VtKTsNCj4+ICAg
ICBsb2NrKCZmc19pbmZvLT5kZXZfcmVwbGFjZS5yd3NlbSk7DQo+Pg0KPj4gICAgKioqIERFQURM
T0NLICoqKg0KPj4NCj4+ICAgIE1heSBiZSBkdWUgdG8gbWlzc2luZyBsb2NrIG5lc3Rpbmcgbm90
YXRpb24NCj4+DQo+PiAgIDEgbG9jayBoZWxkIGJ5IGJ0cmZzLzIzMjY6DQo+PiAgICAjMDogZmZm
Zjg4ODEwZjIxNWM5OCAoJmZzX2luZm8tPmRldl9yZXBsYWNlLnJ3c2VtKXsrKysrfS17MzozfSwg
YXQ6IGJ0cmZzX21hcF9ibG9jaysweDM5Zi8weDIyNTANCj4+DQo+PiAgIHN0YWNrIGJhY2t0cmFj
ZToNCj4+ICAgQ1BVOiAxIFVJRDogMCBQSUQ6IDIzMjYgQ29tbTogYnRyZnMgTm90IHRhaW50ZWQg
Ni4xMS4wLXJjMy1idHJmcy1mb3ItbmV4dCAjNTk5DQo+PiAgIEhhcmR3YXJlIG5hbWU6IEJvY2hz
IEJvY2hzLCBCSU9TIEJvY2hzIDAxLzAxLzIwMTENCj4+ICAgQ2FsbCBUcmFjZToNCj4+ICAgIDxU
QVNLPg0KPj4gICAgZHVtcF9zdGFja19sdmwrMHg1Yi8weDgwDQo+PiAgICBfX2xvY2tfYWNxdWly
ZSsweDI3OTgvMHg2OWQwDQo+PiAgICA/IF9fcGZ4X19fbG9ja19hY3F1aXJlKzB4MTAvMHgxMA0K
Pj4gICAgPyBfX3BmeF9fX2xvY2tfYWNxdWlyZSsweDEwLzB4MTANCj4+ICAgIGxvY2tfYWNxdWly
ZSsweDE5ZC8weDRhMA0KPj4gICAgPyBidHJmc19tYXBfYmxvY2srMHgzOWYvMHgyMjUwDQo+PiAg
ICA/IF9fcGZ4X2xvY2tfYWNxdWlyZSsweDEwLzB4MTANCj4+ICAgID8gZmluZF9oZWxkX2xvY2sr
MHgyZC8weDExMA0KPj4gICAgPyBsb2NrX2lzX2hlbGRfdHlwZSsweDhmLzB4MTAwDQo+PiAgICBk
b3duX3JlYWQrMHg4ZS8weDQ0MA0KPj4gICAgPyBidHJmc19tYXBfYmxvY2srMHgzOWYvMHgyMjUw
DQo+PiAgICA/IF9fcGZ4X2Rvd25fcmVhZCsweDEwLzB4MTANCj4+ICAgID8gZG9fcmF3X3JlYWRf
dW5sb2NrKzB4NDQvMHg3MA0KPj4gICAgPyBfcmF3X3JlYWRfdW5sb2NrKzB4MjMvMHg0MA0KPj4g
ICAgYnRyZnNfbWFwX2Jsb2NrKzB4MzlmLzB4MjI1MA0KPj4gICAgPyBidHJmc19kZXZfcmVwbGFj
ZV9ieV9pb2N0bCsweGQ2OS8weDFkMDANCj4+ICAgID8gYnRyZnNfYmlvX2NvdW50ZXJfaW5jX2Js
b2NrZWQrMHhkOS8weDJlMA0KPj4gICAgPyBfX2thc2FuX3NsYWJfYWxsb2MrMHg2ZS8weDcwDQo+
PiAgICA/IF9fcGZ4X2J0cmZzX21hcF9ibG9jaysweDEwLzB4MTANCj4+ICAgID8gX19wZnhfYnRy
ZnNfYmlvX2NvdW50ZXJfaW5jX2Jsb2NrZWQrMHgxMC8weDEwDQo+PiAgICA/IGttZW1fY2FjaGVf
YWxsb2Nfbm9wcm9mKzB4MWYyLzB4MzAwDQo+PiAgICA/IG1lbXBvb2xfYWxsb2Nfbm9wcm9mKzB4
ZWQvMHgyYjANCj4+ICAgIGJ0cmZzX3N1Ym1pdF9jaHVuaysweDI4ZC8weDE3ZTANCj4+ICAgID8g
X19wZnhfYnRyZnNfc3VibWl0X2NodW5rKzB4MTAvMHgxMA0KPj4gICAgPyBidmVjX2FsbG9jKzB4
ZDcvMHgxYjANCj4+ICAgID8gYmlvX2FkZF9mb2xpbysweDE3MS8weDI3MA0KPj4gICAgPyBfX3Bm
eF9iaW9fYWRkX2ZvbGlvKzB4MTAvMHgxMA0KPj4gICAgPyBfX2thc2FuX2NoZWNrX3JlYWQrMHgy
MC8weDIwDQo+PiAgICBidHJmc19zdWJtaXRfYmlvKzB4MzcvMHg4MA0KPj4gICAgcmVhZF9leHRl
bnRfYnVmZmVyX3BhZ2VzKzB4M2RmLzB4NmMwDQo+PiAgICBidHJmc19yZWFkX2V4dGVudF9idWZm
ZXIrMHgxM2UvMHg1ZjANCj4+ICAgIHJlYWRfdHJlZV9ibG9jaysweDgxLzB4ZTANCj4+ICAgIHJl
YWRfYmxvY2tfZm9yX3NlYXJjaCsweDRiZC8weDdhMA0KPj4gICAgPyBfX3BmeF9yZWFkX2Jsb2Nr
X2Zvcl9zZWFyY2grMHgxMC8weDEwDQo+PiAgICBidHJmc19zZWFyY2hfc2xvdCsweDc4ZC8weDI3
MjANCj4+ICAgID8gX19wZnhfYnRyZnNfc2VhcmNoX3Nsb3QrMHgxMC8weDEwDQo+PiAgICA/IGxv
Y2tfaXNfaGVsZF90eXBlKzB4OGYvMHgxMDANCj4+ICAgID8ga2FzYW5fc2F2ZV90cmFjaysweDE0
LzB4MzANCj4+ICAgID8gX19rYXNhbl9zbGFiX2FsbG9jKzB4NmUvMHg3MA0KPj4gICAgPyBrbWVt
X2NhY2hlX2FsbG9jX25vcHJvZisweDFmMi8weDMwMA0KPj4gICAgYnRyZnNfZ2V0X3JhaWRfZXh0
ZW50X29mZnNldCsweDE4MS8weDgyMA0KPj4gICAgPyBfX3BmeF9sb2NrX2FjcXVpcmUrMHgxMC8w
eDEwDQo+PiAgICA/IF9fcGZ4X2J0cmZzX2dldF9yYWlkX2V4dGVudF9vZmZzZXQrMHgxMC8weDEw
DQo+PiAgICA/IGRvd25fcmVhZCsweDE5NC8weDQ0MA0KPj4gICAgPyBfX3BmeF9kb3duX3JlYWQr
MHgxMC8weDEwDQo+PiAgICA/IGRvX3Jhd19yZWFkX3VubG9jaysweDQ0LzB4NzANCj4+ICAgID8g
X3Jhd19yZWFkX3VubG9jaysweDIzLzB4NDANCj4+ICAgIGJ0cmZzX21hcF9ibG9jaysweDViNS8w
eDIyNTANCj4+ICAgID8gX19wZnhfYnRyZnNfbWFwX2Jsb2NrKzB4MTAvMHgxMA0KPj4gICAgc2Ny
dWJfc3VibWl0X2luaXRpYWxfcmVhZCsweDhmZS8weDExYjANCj4+ICAgID8gX19wZnhfc2NydWJf
c3VibWl0X2luaXRpYWxfcmVhZCsweDEwLzB4MTANCj4+ICAgIHN1Ym1pdF9pbml0aWFsX2dyb3Vw
X3JlYWQrMHgxNjEvMHgzYTANCj4+ICAgID8gbG9ja19yZWxlYXNlKzB4MjBlLzB4NzEwDQo+PiAg
ICA/IF9fcGZ4X3N1Ym1pdF9pbml0aWFsX2dyb3VwX3JlYWQrMHgxMC8weDEwDQo+PiAgICA/IF9f
cGZ4X2xvY2tfcmVsZWFzZSsweDEwLzB4MTANCj4+ICAgIHNjcnViX3NpbXBsZV9taXJyb3IuaXNy
YS4wKzB4M2ViLzB4NTgwDQo+PiAgICBzY3J1Yl9zdHJpcGUrMHhlNGQvMHgxNDQwDQo+PiAgICA/
IGxvY2tfcmVsZWFzZSsweDIwZS8weDcxMA0KPj4gICAgPyBfX3BmeF9zY3J1Yl9zdHJpcGUrMHgx
MC8weDEwDQo+PiAgICA/IF9fcGZ4X2xvY2tfcmVsZWFzZSsweDEwLzB4MTANCj4+ICAgID8gZG9f
cmF3X3JlYWRfdW5sb2NrKzB4NDQvMHg3MA0KPj4gICAgPyBfcmF3X3JlYWRfdW5sb2NrKzB4MjMv
MHg0MA0KPj4gICAgc2NydWJfY2h1bmsrMHgyNTcvMHg0YTANCj4+ICAgIHNjcnViX2VudW1lcmF0
ZV9jaHVua3MrMHg2NGMvMHhmNzANCj4+ICAgID8gX19tdXRleF91bmxvY2tfc2xvd3BhdGgrMHgx
NDcvMHg1ZjANCj4+ICAgID8gX19wZnhfc2NydWJfZW51bWVyYXRlX2NodW5rcysweDEwLzB4MTAN
Cj4+ICAgID8gYml0X3dhaXRfdGltZW91dCsweGIwLzB4MTcwDQo+PiAgICA/IF9fdXBfcmVhZCsw
eDE4OS8weDcwMA0KPj4gICAgPyBzY3J1Yl93b3JrZXJzX2dldCsweDIzMS8weDMwMA0KPj4gICAg
PyB1cF93cml0ZSsweDQ5MC8weDRmMA0KPj4gICAgYnRyZnNfc2NydWJfZGV2KzB4NTJlLzB4Y2Qw
DQo+PiAgICA/IGNyZWF0ZV9wZW5kaW5nX3NuYXBzaG90cysweDIzMC8weDI1MA0KPj4gICAgPyBf
X3BmeF9idHJmc19zY3J1Yl9kZXYrMHgxMC8weDEwDQo+PiAgICBidHJmc19kZXZfcmVwbGFjZV9i
eV9pb2N0bCsweGQ2OS8weDFkMDANCj4+ICAgID8gbG9ja19hY3F1aXJlKzB4MTlkLzB4NGEwDQo+
PiAgICA/IF9fcGZ4X2J0cmZzX2Rldl9yZXBsYWNlX2J5X2lvY3RsKzB4MTAvMHgxMA0KPj4gICAg
PyBsb2NrX3JlbGVhc2UrMHgyMGUvMHg3MTANCj4+ICAgID8gYnRyZnNfaW9jdGwrMHhhMDkvMHg3
NGYwDQo+PiAgICA/IF9fcGZ4X2xvY2tfcmVsZWFzZSsweDEwLzB4MTANCj4+ICAgID8gZG9fcmF3
X3NwaW5fbG9jaysweDExZS8weDI0MA0KPj4gICAgPyBfX3BmeF9kb19yYXdfc3Bpbl9sb2NrKzB4
MTAvMHgxMA0KPj4gICAgYnRyZnNfaW9jdGwrMHhhMTQvMHg3NGYwDQo+PiAgICA/IGxvY2tfYWNx
dWlyZSsweDE5ZC8weDRhMA0KPj4gICAgPyBmaW5kX2hlbGRfbG9jaysweDJkLzB4MTEwDQo+PiAg
ICA/IF9fcGZ4X2J0cmZzX2lvY3RsKzB4MTAvMHgxMA0KPj4gICAgPyBsb2NrX3JlbGVhc2UrMHgy
MGUvMHg3MTANCj4+ICAgID8gZG9fc2lnYWN0aW9uKzB4M2YwLzB4ODYwDQo+PiAgICA/IF9fcGZ4
X2RvX3Zmc19pb2N0bCsweDEwLzB4MTANCj4+ICAgID8gZG9fcmF3X3NwaW5fbG9jaysweDExZS8w
eDI0MA0KPj4gICAgPyBsb2NrZGVwX2hhcmRpcnFzX29uX3ByZXBhcmUrMHgyNzAvMHgzZTANCj4+
ICAgID8gX3Jhd19zcGluX3VubG9ja19pcnErMHgyOC8weDUwDQo+PiAgICA/IGRvX3NpZ2FjdGlv
bisweDNmMC8weDg2MA0KPj4gICAgPyBfX3BmeF9kb19zaWdhY3Rpb24rMHgxMC8weDEwDQo+PiAg
ICA/IF9feDY0X3N5c19ydF9zaWdhY3Rpb24rMHgxOGUvMHgxZTANCj4+ICAgID8gX19wZnhfX194
NjRfc3lzX3J0X3NpZ2FjdGlvbisweDEwLzB4MTANCj4+ICAgID8gX194NjRfc3lzX2Nsb3NlKzB4
N2MvMHhkMA0KPj4gICAgX194NjRfc3lzX2lvY3RsKzB4MTM3LzB4MTkwDQo+PiAgICBkb19zeXNj
YWxsXzY0KzB4NzEvMHgxNDANCj4+ICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsw
eDc2LzB4N2UNCj4+ICAgUklQOiAwMDMzOjB4N2YwYmQxMTE0ZjliDQo+PiAgIENvZGU6IFVuYWJs
ZSB0byBhY2Nlc3Mgb3Bjb2RlIGJ5dGVzIGF0IDB4N2YwYmQxMTE0ZjcxLg0KPj4gICBSU1A6IDAw
MmI6MDAwMDdmZmM4YThjMzEzMCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAw
MDAwMDEwDQo+PiAgIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDAwMDAwMDMg
UkNYOiAwMDAwN2YwYmQxMTE0ZjliDQo+PiAgIFJEWDogMDAwMDdmZmM4YThjMzVlMCBSU0k6IDAw
MDAwMDAwY2EyODk0MzUgUkRJOiAwMDAwMDAwMDAwMDAwMDAzDQo+PiAgIFJCUDogMDAwMDAwMDAw
MDAwMDAwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDAwMDAwMDA3DQo+PiAg
IFIxMDogMDAwMDAwMDAwMDAwMDAwOCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwN2Zm
YzhhOGM2Yzg1DQo+PiAgIFIxMzogMDAwMDAwMDAzOThlNzJhMCBSMTQ6IDAwMDAwMDAwMDAwMDQz
NjEgUjE1OiAwMDAwMDAwMDAwMDAwMDA0DQo+PiAgICA8L1RBU0s+DQo+Pg0KPj4gVGhpcyBoYXBw
ZW5zIGJlY2F1c2Ugb24gUkFJRCBzdHJpcGUtdHJlZSBmaWxlc3lzdGVtcyB3ZSByZWN1cnNlIGJh
Y2sgaW50bw0KPj4gYnRyZnNfbWFwX2Jsb2NrKCkgb24gc2NydWIgdG8gcGVyZm9ybSB0aGUgbG9n
aWNhbCB0byBkZXZpY2UgcGh5c2ljYWwNCj4+IG1hcHBpbmcuDQo+Pg0KPj4gQnV0IGFzIHRoZSBk
ZXZpY2UgcmVwbGFjZSB0YXNrIGlzIGFscmVhZHkgaG9sZGluZyB0aGUgZGV2X3JlcGxhY2U6OnJ3
c2VtDQo+PiB3ZSBkZWFkbG9jay4NCj4+DQo+PiBTbyBkb24ndCB0YWtlIHRoZSBkZXZfcmVwbGFj
ZTo6cndzZW0gaW4gY2FzZSBvdXIgdGFzayBpcyB0aGUgdGFzayBwZXJmb3JtaW5nDQo+PiB0aGUg
ZGV2aWNlIHJlcGxhY2UuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBGaWxpcGUgTWFuYW5hIDxmZG1h
bmFuYUBzdXNlLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9o
YW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+PiAtLS0NCj4+ICAgZnMvYnRyZnMvZGV2LXJlcGxh
Y2UuYyB8IDIgKysNCj4+ICAgZnMvYnRyZnMvZnMuaCAgICAgICAgICB8IDIgKysNCj4+ICAgZnMv
YnRyZnMvdm9sdW1lcy5jICAgICB8IDQgKysrLQ0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9k
ZXYtcmVwbGFjZS5jIGIvZnMvYnRyZnMvZGV2LXJlcGxhY2UuYw0KPj4gaW5kZXggODNkNWNkZDc3
ZjI5Li42MDQzOTllNTlhM2QgMTAwNjQ0DQo+PiAtLS0gYS9mcy9idHJmcy9kZXYtcmVwbGFjZS5j
DQo+PiArKysgYi9mcy9idHJmcy9kZXYtcmVwbGFjZS5jDQo+PiBAQCAtNjQxLDYgKzY0MSw3IEBA
IHN0YXRpYyBpbnQgYnRyZnNfZGV2X3JlcGxhY2Vfc3RhcnQoc3RydWN0IGJ0cmZzX2ZzX2luZm8g
KmZzX2luZm8sDQo+PiAgIAkJcmV0dXJuIHJldDsNCj4+ICAgDQo+PiAgIAlkb3duX3dyaXRlKCZk
ZXZfcmVwbGFjZS0+cndzZW0pOw0KPj4gKwlkZXZfcmVwbGFjZS0+cmVwbGFjZV90YXNrID0gY3Vy
cmVudDsNCj4+ICAgCXN3aXRjaCAoZGV2X3JlcGxhY2UtPnJlcGxhY2Vfc3RhdGUpIHsNCj4+ICAg
CWNhc2UgQlRSRlNfSU9DVExfREVWX1JFUExBQ0VfU1RBVEVfTkVWRVJfU1RBUlRFRDoNCj4+ICAg
CWNhc2UgQlRSRlNfSU9DVExfREVWX1JFUExBQ0VfU1RBVEVfRklOSVNIRUQ6DQo+PiBAQCAtOTk0
LDYgKzk5NSw3IEBAIHN0YXRpYyBpbnQgYnRyZnNfZGV2X3JlcGxhY2VfZmluaXNoaW5nKHN0cnVj
dCBidHJmc19mc19pbmZvICpmc19pbmZvLA0KPj4gICAJbGlzdF9hZGQoJnRndF9kZXZpY2UtPmRl
dl9hbGxvY19saXN0LCAmZnNfZGV2aWNlcy0+YWxsb2NfbGlzdCk7DQo+PiAgIAlmc19kZXZpY2Vz
LT5yd19kZXZpY2VzKys7DQo+PiAgIA0KPj4gKwlkZXZfcmVwbGFjZS0+cmVwbGFjZV90YXNrID0g
TlVMTDsNCj4+ICAgCXVwX3dyaXRlKCZkZXZfcmVwbGFjZS0+cndzZW0pOw0KPj4gICAJYnRyZnNf
cm1fZGV2X3JlcGxhY2VfYmxvY2tlZChmc19pbmZvKTsNCj4+ICAgDQo+PiBkaWZmIC0tZ2l0IGEv
ZnMvYnRyZnMvZnMuaCBiL2ZzL2J0cmZzL2ZzLmgNCj4+IGluZGV4IDNkNmQ0YjUwMzIyMC4uNTM4
MjRkYTkyY2MzIDEwMDY0NA0KPj4gLS0tIGEvZnMvYnRyZnMvZnMuaA0KPj4gKysrIGIvZnMvYnRy
ZnMvZnMuaA0KPj4gQEAgLTMxNyw2ICszMTcsOCBAQCBzdHJ1Y3QgYnRyZnNfZGV2X3JlcGxhY2Ug
ew0KPj4gICANCj4+ICAgCXN0cnVjdCBwZXJjcHVfY291bnRlciBiaW9fY291bnRlcjsNCj4+ICAg
CXdhaXRfcXVldWVfaGVhZF90IHJlcGxhY2Vfd2FpdDsNCj4+ICsNCj4+ICsJc3RydWN0IHRhc2tf
c3RydWN0ICpyZXBsYWNlX3Rhc2s7DQo+IA0KPiBXYXNuJ3QgdGhlIGlkZWEgdG8gdXNlIHBpZCBm
b3IgdGhhdCwgYW5kIG5vdCBhIHJhdyBwb2ludGVyPw0KPiANCg0KDQpUbyBxdW90ZSBGaWxpcGU6
DQoNCiAgICAgSSB3b3VsZCBzdWdnZXN0IGEgZGlmZmVyZW50IGZpeDoNCg0KICAgICBNYWtlIHRo
ZSBkZXZpY2UgcmVwbGFjZSBjb2RlIHN0b3JlIGEgcG9pbnRlciAob3IgcGlkKSBvZiB0byB0aGUg
dGFzaw0KICAgICBydW5uaW5nIGRldmljZSByZXBsYWNlLCBhbmQgYXQgYnRyZnNfbWFwX2Jsb2Nr
KCkgZG9uJ3QgdGFrZSB0aGUNCiAgICAgc2VtYXBob3JlIGlmICJjdXJyZW50IiBtYXRjaGVzIHRo
YXQgcG9pbnRlci9waWQuDQoNCk9mIGNhdXNlIEkgY291bGQgc3RvcmUgdGhlIHBpZCBhcyB3ZWxs
IGlmIHlvdSBwcmVmZXIgdGhhdC4NCg0K

