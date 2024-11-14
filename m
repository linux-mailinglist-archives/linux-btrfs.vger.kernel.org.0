Return-Path: <linux-btrfs+bounces-9629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCB89C83D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 08:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B07E6B2851C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 07:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5814C1F26D8;
	Thu, 14 Nov 2024 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TIYdtIoO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fomrGjlc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8151E7C0F
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568179; cv=fail; b=DHcTesXOIXKk/65eN4U1RKTLnAaIeKHnQSITJE3NSpBtdpmtG6KLtDYBsJISAAiVANHOzoUc2y4baOrre1KNjqZay8HB2KlBKP5OUjBVQneu2rtUwSN/WoruPzDWkkoFxIAlSEhriksFJlhi0XxWaGikLcm9xKafL6BN70WBYWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568179; c=relaxed/simple;
	bh=QvOLotgjec+SPwZcobwwl+/g+bPIVVZvN6XKw2nWOiM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hh/A4CghSLYNX0uV9XXx4d+u7Y1HT6CuhFB45Q7NUQtgL3atwMPct2+hFbC62dXixUtZv9mlUZMb0PfphG6lfoy93YfqH/YUtEaR/P8k6CUuaCES5hOTrNUyIIaAT9ca5a1lq+aJ4XpFWMbaDoMU0nRR4imEtvTBmTqKdac7iIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TIYdtIoO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fomrGjlc; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731568177; x=1763104177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QvOLotgjec+SPwZcobwwl+/g+bPIVVZvN6XKw2nWOiM=;
  b=TIYdtIoOGXpQN9vWU/VMowUwNNc+hWysEfOSfP5SLkeMJUltRjcA3Ydx
   /Z+cDHsZZhwuwkQcmc3OCIuMr8ryX33/MONtgdnGp+870Gf8DWZGcYMgo
   iXvuXUAe+hyY10WVfztSiwORV+oJnZzO8tVAzkLPfX5PuJK+SULiqBQ1T
   Rk/Cgj/VJB46LbAm36cr2WOxbEs2QUZOWSyP/1NXu533ycsqgYTJ/Dh7q
   hCvy+YQqM7zawHXLKAYMn+3Mcdvx3po3XDRiX9N81NyAoZTjSzJc0OwWr
   ZOi0dIxpEb3kXKhZIN67odcV31eu0V3j/DlbW9BziO2gC7LQ2ZuV35HVd
   g==;
X-CSE-ConnectionGUID: LSUtjFuPRfyD672vxFxNXA==
X-CSE-MsgGUID: ZOT6cNxqS5Obvelp29aFHA==
X-IronPort-AV: E=Sophos;i="6.12,153,1728921600"; 
   d="scan'208";a="32527825"
Received: from mail-westcentralusazlp17011030.outbound.protection.outlook.com (HELO CY4PR02CU008.outbound.protection.outlook.com) ([40.93.6.30])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2024 15:09:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuJ0US9R8ckkC7oA780iusyYUqDvEqCn5xTVOt6Tb6hJI2bk10l5JUWb4Df2zFi2gEHIdzdeSD5a+hjyC3JTymWlciy+UFl0Gn32vVPynhJD9NbQH33NSsJFMr2pVD3e4ZcIs3gfBIyCgRNI2xTxOLXYjboy0OFbmAmIyO5WGaSSwIlfiLuKLHuuA7ByyT19TMd2tfkrbHQA8Gco65JpsMM71LjY8NRtBV7SDLNiroCR+3q0Z420WwzmvbNBsZ7LeHMiunDCEspfjA12VY6g6XeqzclonuvyR23xEfBpCfLmiLQzdiGowckKzVRIT81KScwpumY3Ud08/hhuEagrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsSaIhzon/3FNm9ZwPJjfBh7zfqAJO8gGyBcsuyUdIc=;
 b=jTs2V1EKGzUb+Zyg9QY8sEcmGQutHqtlYK6JCGXTZx8a7E8B7SbBqwnDpTZkocof5gMI19OxWI9kf32RN3D+ncqFQvvho+pK8jZRxBVDDTw4818mk6wevkXJeF71v0RSzOX1eBTFaVK6KzjF0moysSMnhsqWO4Zy0jkaxstAjZA486D4hllAXQKgB1JFzz7J3pUW/ih0VAWkYIPZ9D876c9fuNLvK02E5mzT9GSqcKMZgSOJ4uT+kwiNzsL0RYUZ+YUTgy6X8VWwYe7kfW9tXSY0MyNPIPZ2N/AOw3I2+PJT/Dk5lEW5OB3WPzkDDvjEpbLoQOizszjUQQh8aPDsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsSaIhzon/3FNm9ZwPJjfBh7zfqAJO8gGyBcsuyUdIc=;
 b=fomrGjlc1a+wmI1c0byr68QkfjDVisfN5u2ExNbM+GfizkR2dM2v5x8YHzz/HPozMsgf4VldBmdKzAzH64wzTINomyIsIUV9/beIeWLAQBQ11h5/t02LAXYzu9915/ydC84uxG+aobNpRtxq7pWiPMTnTiiczcvr/MXj+jB2irw=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8566.namprd04.prod.outlook.com (2603:10b6:a03:4e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 07:09:22 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 07:09:22 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.cz>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: zoned: reclaim unused zone by zone resetting
Thread-Topic: [PATCH 3/3] btrfs: zoned: reclaim unused zone by zone resetting
Thread-Index: AQHbNA4FZl0tQwF260mzf45S9KGKy7KxyV2AgABWCACABEDAgA==
Date: Thu, 14 Nov 2024 07:09:22 +0000
Message-ID: <2s3zlqrmizzprxivdfobwsef5n4zdbwtpwwbvg6wyy7gd4axpc@dxjfqy6ohuy4>
References: <cover.1731310741.git.naohiro.aota@wdc.com>
 <72946446ca8eda4477e0a11ea0b9d15cb05aa1e1.1731310741.git.naohiro.aota@wdc.com>
 <a419cf9f-7fa3-4f75-b459-23c1fe014c14@wdc.com>
 <20241111141234.GO31418@twin.jikos.cz>
In-Reply-To: <20241111141234.GO31418@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB8566:EE_
x-ms-office365-filtering-correlation-id: bf6d67ae-1e95-4761-b8f5-08dd047b43cc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yIeRHOgPPtEn0oYdjC97yVfkCwji6BR/EFEe/7yKb6NLImsqb3iYs0YbPVsO?=
 =?us-ascii?Q?Py5WFiSJxxNyCmowabZ4LLJSLsszi6JVSjOOUqp+pNHz2yRKOWLEoo7nZ/d0?=
 =?us-ascii?Q?QADKqZQkY3mLoG/shVJXCmojd60Fj2ddUsgkhSXtASNpOMZSun8cBNxcvOVT?=
 =?us-ascii?Q?xia7C6pm0UC2o/lP04s994uDig+dlUFzQgtiXFcvdydvHwHciAr4E4pgnfeQ?=
 =?us-ascii?Q?4scLYrpBJYHPzzxZuc+jBox4KmRWIqJdBbA3nznRHokuy4BtUhx/y+FVctgz?=
 =?us-ascii?Q?Z4NUIg6iQrS7HmL6PnLEkma3aKTi1V4bVzLhZrDAU55VyJkZSi9x5eaOzhVX?=
 =?us-ascii?Q?2hvKWqAKs/d6Q8jwtUCt7npD16L+3Ef4k42GU2NBs+j0a+2jY1njTA8DY6JT?=
 =?us-ascii?Q?AVZCveD8x8D8daTF7tefTwcuOe4COApC8m0AUsRGJn9XHE6a0B9EmMCn5Nz0?=
 =?us-ascii?Q?svkEI+txlEDTqYfiTI49syfijc8iRk4a68h2IOgKbk9t9y4nIZ/UtVadBqD5?=
 =?us-ascii?Q?sR4E7cgb24VFIkPcvhvNbB00REgElMMTme97YOZE16e68jZGb8ArMUi6O334?=
 =?us-ascii?Q?VXSQdZZ0cEPs3+jcqxTno3NzpbA/reOSTD1wRkV4u/Iw2IA1dGD2dwTY1WDB?=
 =?us-ascii?Q?8u+Pj/Ks+JhGMN52G3AURXN2NOOjCWGlP1ZQC+f2vW6vyVuoRA/bd3pOgjSV?=
 =?us-ascii?Q?MNtXAXQ1aBljXZF3xWs0JSw94tIJW0unz7C5q6uHvpcY0hz9dIAEm7qq5grd?=
 =?us-ascii?Q?3Gt3OwhHVvxBTj8M924k3JUDVoNiwBFf/EpSUhtrK/+fmw2BqMSjibhHWzQ9?=
 =?us-ascii?Q?CV/ptTGT3YgLPYeOComNJUodOpWaoP91qix4jGDa5/YkRuX1L5L2jVRXulN+?=
 =?us-ascii?Q?tY02e841N1JASdg4OoOt0MSqu87Gy7UN8sjYyjCMZO/H0t+6EijeIPpNaLjm?=
 =?us-ascii?Q?3Kc/8MUlxhJgivXiLaHQ8epc6Xl31EFXerjsls38NrUcqJH+zOnmScEz1yQ3?=
 =?us-ascii?Q?ws0cTsWzMUYO2BkKtWdXJPatxEX5/9lpeHWwdBnQSg5yvBrUXJSDAVlKNmfu?=
 =?us-ascii?Q?o993R5sjg11WDfsv+UKzmh/vqipWKIf2DSHO3vIvP+oGaC/O0OqLdD8NpHn3?=
 =?us-ascii?Q?oFGnE9K/4LrUT/MdZFgWqMQ5Kf9eJru4Q/KwdJGs9zUO2mn2CSn0Un4rm8Td?=
 =?us-ascii?Q?E2faVJgaXm+Mf3onqyWu8EK57fGhCrpN2M/82vOkBVGGlz8N8Y8svme4puci?=
 =?us-ascii?Q?AuDGPXXexYCdXKlFuktjMvcwIdtdLLC00QCsDFBSJIBqEvVKL3MupbFPlljI?=
 =?us-ascii?Q?lMsOBAMTC6o3EeAaqf/bYlIT1zng/ug51PJM4neORBCh4RCR4N23xV0W2ETf?=
 =?us-ascii?Q?9g6jX9g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p+OgFwfu95ek7TiFnwuil6nF/lQ0vqbCOBuQMuhFPpiTATAyUWUv2AUpzmRq?=
 =?us-ascii?Q?ujtI/lq/ho6Cqxun/8tAn31CdgUVghcaW+ROZcF2fyGWXCr+Iyn+3V1GRmFS?=
 =?us-ascii?Q?E68VsdVGOyt2bmt2UiFK5LWyAEMOKcJoTi5fCR3Nz1TOSB+ZrIkIqQ+ftCCg?=
 =?us-ascii?Q?y7FrIAUldS1BM9NMUv+7JHWw5I+O++dFtSBoUDXXT7leVqepkAzJXfyhSKKz?=
 =?us-ascii?Q?I2j4O4OL0EFc5WS0KIVqTpwdJhu02bw+l6kqir1oD1CvBlvL1OSfKjX1OAot?=
 =?us-ascii?Q?JegIGCaRhvTJEBdp9+uC7NYzZepPBY4OjK//wdp0XtVNHDh9AGOZVXtqpG/o?=
 =?us-ascii?Q?FHV+3BasJO5e4PxPuFT0mi0ITxzG+BChMOSA3rp2etIBvoOoljEjs4LRCpIh?=
 =?us-ascii?Q?jPkP5excrTyP7m/bqQmwHaVfOAtlyOXxtCYQsmuFDBCwxsDG35VK57P7jWr+?=
 =?us-ascii?Q?1RjgeJG+/+RFjD2k5jXO/qaTgR4LN8B0xFAvVS6mpGoVL4Y8a2PS+KXJe1wt?=
 =?us-ascii?Q?DRPjQkBeQXDDX5/SpT+NTFxlifbeCqSsJp+fgz+xkoKbTtUG9BOntfTfuSSt?=
 =?us-ascii?Q?/AdjCDWwJG3iCBI8Bnyg+kKvphA7skAJl+rK+pP/V77wskFjYz68+q8Nnj5V?=
 =?us-ascii?Q?8BYaHh7qNcilzQ9fJeMJlOOCArtkW3ggkeNSBg5XyHlp/eJZR0R4cDR99bF7?=
 =?us-ascii?Q?TPPYWgHy2suvt4zp20U2mrIU7UNSblm4F8A/ifUZvVEFGTZ3ybSitNl006IW?=
 =?us-ascii?Q?29z5eqU2NuJkHfBSgjFv33yoD6xrb95ow0PDOtiIuxGl4I2WBFfnUgXhYnur?=
 =?us-ascii?Q?GCeHcas8O8T4K++8kKdDzPfPz8bgh5NIaVhIZBL/0k5P1e2tRY8nDutpTWhE?=
 =?us-ascii?Q?Z7BeieB6roveF8Be6EjtbNxPpQRMlawbfUrgVsOHtxWbKN63GKaiFk1azH67?=
 =?us-ascii?Q?/JvR7/+ex38pxydVTJSILTcoH553vwfIHRsRDde7XcQfWa3bBP5TEkPlnQrG?=
 =?us-ascii?Q?4+6bVXlv9taeKq07A56S4s5JXB9KgWaVp10kdht3ztjnAD08eKrZNEGGg3bn?=
 =?us-ascii?Q?GZrqAGHRbf5hyrakePlyQwMwdoyIVRd2PhHpGHcpeoZVjxEi2Q+YBEmUQ73q?=
 =?us-ascii?Q?tWU7yJ1AERkLmDeXqAoSNvVCzh1zBtdZdD39Rt2GpeH1SIwOu1Bl4mbIvmLF?=
 =?us-ascii?Q?PdQl1ho69L3SFzR8e9OsmGkYAtt6IpPtgHsqQ6EihGRrfgHNbj7ci5QWl4Bz?=
 =?us-ascii?Q?GYNt2UO2KUi9MthN4mrr2kcXqABbAd0qUgIIBYVQ3IW3tjZqpt5cvjt5xO72?=
 =?us-ascii?Q?nucvVGa2QdIFQPclHS1gmlvtbd7eBGWFhGq/Qio4GDikawcu5Tq4yHrqqe+v?=
 =?us-ascii?Q?MNMCo5ykgldnjkIogSalzweKsRbs0PoWvR7JzlLd0FPLWtAyQbY1qZ5P8PIV?=
 =?us-ascii?Q?33ZGWayA5/WnDVpcLCGpkCJggQRgrraPV0yL+NlwLsbnBmQ4nytnEodADltc?=
 =?us-ascii?Q?PQx+xclhrBN5k4cDZR7rWn+JzaFEj2bV7KMXAkCnAPxwjok3qfmm5FgHHss9?=
 =?us-ascii?Q?Dqy3qeLBeW8FU5S3qIjUp7bJTOtEiO3cjMeROz3+umLPuFcm4QelfDPAShrl?=
 =?us-ascii?Q?8A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB13E911A4F92F479344D739E0F3BC6E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/scwMvPlYZ/iFZWaGTNanbgRdyiWg4yEU1obFRmT66pOshZiLXk8NE2zTkpqQDRGPKykiJ8mFEAjgb8AYJJ28Ar37jVs277uoMTMspCiNQN1FhF9tmISZWCRVvXZ0WorMTeO2HuBczpVIB6eFqLaUkUVe79lANXXZ41/sqxfADEhNQF9DXa3MpyCz/E5N6qMNaMMHzMIVOh3GfLYTHOed5tyaZCBboNz0GgTwQAN966GMB9MrlznjvzwDgCxngoKysfIY+VrRSwAaZnFlLkDkyBMdnE/KXcIV+Mp3DtJd4YWrhvwrGZPxmx1bTfm4cLLbhqzSFRdACNkZbuXltARVcfmJuq3W7EcAS4EAQ0TE+wtzIYGs01USBxchxZMn32sqR3h73i8pYJtZ9bEgyypV5Hre18oBKM4i1YrVs/FGniY2WJQpgs23NpxIRbjwy0RntbI7Cuvm/dNDYoqbDK8+GwyXMfsYXRyDNu4SNXXEiwjl06KM0p2+CDjogcftPw8Sdz/LKaADxVMb20dLcyW6bWf6KEBM03WQbZkAXzQEDD4KUexn/NwUmu24iFfr8x0OALug2rbQB5kAT7yGeeA/q7qDYBqCagLwXCBAevsbcIioXPB0agzc0qG4lBkzaio
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6d67ae-1e95-4761-b8f5-08dd047b43cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 07:09:22.1239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Mst1DXZdbyLNSzJXtl1ZtyVcYtfMZY8SNaBePABm3lAfTTFZ3rkmNUzLgPCfUcAxKrY6AqM14B/5WCd2RmUsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8566

On Mon, Nov 11, 2024 at 03:12:34PM GMT, David Sterba wrote:
> On Mon, Nov 11, 2024 at 09:04:39AM +0000, Johannes Thumshirn wrote:
> > > +		/*
> > > +		 * Here, we choose a fully zone_unusable block group. It's
> > > +		 * technically possible to reset a partly zone_unusable block
> > > +		 * group, which still has some free space left. However,
> > > +		 * handling that needs to cope with the allocation side, which
> > > +		 * makes the logic more complex. So, let's handle the easy case
> > > +		 * for now.
> > > +		 */
> > > +		scoped_guard(spinlock, &fs_info->unused_bgs_lock) {
> >=20
> > Again, not a fan of the scoped_guard() macro...
>=20
> Yeah, we may use the scoped locking for something in the future but so
> far it would be quite confusing to mix explicit locking with scoped for
> current data structures. Subjectively speaking I don't want to use that
> at all.

As I wrote in another reply, mixing happens due to usage of "continue" in
the outside loop. Well, I'll rewrite this with the ordinal locking style.

