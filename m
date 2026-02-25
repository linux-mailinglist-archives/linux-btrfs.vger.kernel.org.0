Return-Path: <linux-btrfs+bounces-21915-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPk7LJLbnmkTXgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21915-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 12:22:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A05196602
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 12:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0F1E300ADAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 11:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8827D38F932;
	Wed, 25 Feb 2026 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nq7HoK4a";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FT4jhEEQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9985524DCF9
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018572; cv=fail; b=XmzKeWnv3chuPlZhSker7yd+WVC6uM1PyZyLqhiNfg/bEwYaJ0L0swMBktE9CFiHjP50prB1NxnN96U8x2OwI3v2c9CUunmoSLV82W2rYyt87IsQAhliV/rYuvjMAGtXUL9M5maJcq2wkSLfoKyr78P7hTijEC1LF4EsRRgDNf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018572; c=relaxed/simple;
	bh=n+2JkpamOJRy5YLNYuFS2f+E9DHtP6+ohk2dabNs5vI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gM84dp2DYsrj4Bym/Em6VSjzlOxOFt5NH8rdhT3GbGDVQviuUrZ5vxkYHLqgHyuhbjPINx5HBtJEShVMZ04cRN5v21GZ3xJkSTLTXh2srW7hki/yYDcq5WDySxSZ3tb4oaUXRs9iujP4U18jZ7tOVg7IwaKTTTrXzaI3IWHmrRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Nq7HoK4a; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FT4jhEEQ; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772018571; x=1803554571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n+2JkpamOJRy5YLNYuFS2f+E9DHtP6+ohk2dabNs5vI=;
  b=Nq7HoK4ayi0rokwpsVH+MNFAM9DlaiHRm2XeIDVIo4maqx4Z2T9YFWD8
   Kg12UgWfQMJ4SGRidBaRfAeIrrN9cl5P9f5A8AifUTZAV1Q1wv1HNl4Jl
   sfrzJ9R6/h6Ecm+/+mb+KKCpdZctvnXGXdPG0IgrPrLUKmKMA3PYz1dvT
   gqEbexMZ+Pc/NBZO8l3WDQgaDJNM1bwi12zBUDW9N3nFBdbEew0/8hjJD
   3W+uBk4QjYlXY7YZO8jPVx28sTk6YZlqBPGsSLBw1GyX3c28FY3364XJX
   lfAvJymTiqTgR8jn04y8NTiL85ohG0CRoijdvqWvr8Iy37fJ84V1EBniM
   Q==;
X-CSE-ConnectionGUID: 4hU9yHLWTLiGj4bAUlQm3w==
X-CSE-MsgGUID: sPBt1r9/T9uIxPzQsiiybg==
X-IronPort-AV: E=Sophos;i="6.21,310,1763395200"; 
   d="scan'208";a="141983193"
Received: from mail-centralusazon11010045.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.45])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Feb 2026 19:22:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fi/vJWYzk5V0jKWxPCmoTZTBCCAZh40iEJQA+coGLrfpmcWvrHIUWFS4gZGvRNq0Xo4+gGMn6LcCMfKgjixDU0HC4v5xW6fRvIKskF/UR7dZ8M7qvh+aN3KA64IvExk7F/dAPniicwOPPWX+/CvG3iJxxW3zEqpzoIuLh4d7y6JRu533pFButD2KjaNkazSCVF5XZ53RypeILXshnsKPseA/9CalJqj/PAnq91SkvICgt2qB0YWh4fCEM1gTGSYimjg5/j2b6rXNs007D1ktMndcVWkz5mq0tptENGDsjXacX8RN+J2sEbmGkM+9EtVsbrCJcLinRUNhaeJwJlz6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+2JkpamOJRy5YLNYuFS2f+E9DHtP6+ohk2dabNs5vI=;
 b=o2lPsVjr7umVh+drNTi/Wf3Voz/Uo19N5L67j0vUfJhS0FB7nxuN/7siR8PGPe8bV9iXlvrNwpQ4ccvplxsvbOw/KayoWbWDhPRwLODGCruRkXygaG7vMrl5mdyd+aaCGikliNWc2i7P1BTdWD8+Nwf0iLQB39mnKvdBIerTcQwPTc34rFPJQl3DwkPbwnnOTFwgLwko0zXfyTFJ+CHX2xUoNZf84o9tqhF0FrP+mvTDOTghWGGM207bOjlBilGKppnoAsBQvBCStctwj1N4gCULUTwmnlT8YCu3AuaoVzBUfaXQ7A94SivNFAtKzRJlhd+Ij7OIGJHUudvetz1Slg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+2JkpamOJRy5YLNYuFS2f+E9DHtP6+ohk2dabNs5vI=;
 b=FT4jhEEQnGi7ffmUzgUfEYpHX0NyJQMVoAZ1axCFlcAUG164fN7Q36pOSWKLBMMvVBBZ6j/u5optLX99ZUz2W84DcS+yeqjMhUXheQuMxvKGy3JwyQMyta6MNBBJvCkpa5hfFv52KTEj/zEPjd/L3v8J1GarKdemTibpnPdfFJ4=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CH7PR04MB9571.namprd04.prod.outlook.com (2603:10b6:610:250::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.10; Wed, 25 Feb
 2026 11:22:43 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 11:22:42 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Mark Harmstone <mark@harmstone.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "boris@bur.io" <boris@bur.io>
CC: Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: fix use-after-free in move_existing_remap()
Thread-Topic: [PATCH] btrfs: fix use-after-free in move_existing_remap()
Thread-Index: AQHcpkKTT3lzB9rU106kg7B4ymKMLbWTRZcA
Date: Wed, 25 Feb 2026 11:22:42 +0000
Message-ID: <470807f2-3e2c-49d0-8b74-e5a71b233ad4@wdc.com>
References: <20260225103557.18457-1-mark@harmstone.com>
In-Reply-To: <20260225103557.18457-1-mark@harmstone.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CH7PR04MB9571:EE_
x-ms-office365-filtering-correlation-id: b7807767-7c06-4669-7b45-08de7460316e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 27ZXOpGcvZgOZVmrFHVi7NsCGnSigupVblwY3mSzZhrMQ/WMAFzIDF1RDtMYg/mSYtvbmpRwS4lEDiTbjLD0QGQlAbWoaPkNLGf5rSSGaDaeognwCZ01V4ryq9V5Q0NNjILBJLCHeQHAz9tqqP5bj2B3hvyFbx3J8dhPIRk3Totl5urbjelmgMwWLfhC31n65iYIdxEfAbd8kEG3+lJfoIVVW3Z58oUsj0FGpZanZJvwGmfBbyhz3rtikbl+tNlrrNx87Q/UcS9kjmbQAoBda9/h/D60uFz8wQZSuQCJx4YygfFWYqlPjxHaOWBIA3sNkxz+BTI0mMwhgjrIRr5ACLlSsXG6j9ZuPyha/bmod24zLmgTJuIioTwUM8FSloh2eu8Lk6YvRJ+co3YR+vOuyOBsY8lRSZzxCXFK5088d7uSRVAVGC6im+dNMsCg6lNNFITfFVuNgtkzswc0ZpydlA7YDcMXLDofRxDFD3hnfuM9SE9QA0iWlsBh6hZBmvohg7FQdAJosLNadgA7yUyJ8bEfCMnTIiy3DMKAQXbYw4xrdM8ZopnTxqzTXzvuJNHj1/Kx+rVNCi1DqrA17PVDwRzR8Z0F6QfZJsN9EoCQy5yGZTMfAkIOlAP8nYz8Q+G1Fu3/s2XOumykg/7fkO1gAWXj1ULnLMiggzIU57AzzQrbbIQG06C7BaOU1nCxRhFV2jpjbReyeChLdza6LzAbVe3bicPNv2DrUeH+Mn1wYbGpgyceUMBFZAqNKDqYdGd4XXjnxeCa1B/eUuy1ES0xJAAC5kr0NmxP1vUvQikqNQU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHZDL1F3aEI3aStOWGJ3Rk9Qc3RzMU1MSlo4WXp6bU1NeVptZGdHdmY3eVBI?=
 =?utf-8?B?eUdiRkRFMXE3THJDRjMxWWxudnZEVEdpR2NiSGxBMDdyZHpjL2hJV3hDS3po?=
 =?utf-8?B?NnViOTVWTmVIVzNkS3l5dWZGNWVYSDRvVjlaVkMxWFBXa05hcmRrYjE0T1c1?=
 =?utf-8?B?S1lveXF1NmZYekxWRFovRlFVUUFQaExGSEZhU0dzUDNROHArcy8wTXM0ei85?=
 =?utf-8?B?NWtmUXNwTTU1Y05XblRad0ZlQ1JMMWUvYWFtNlNqd2c3d2xnaVhXNDM4QXZW?=
 =?utf-8?B?NWxBTVU3RWdyZERVcU85RzdyUi8rTzlNR3p1VWNGcGZHMlpnY3dkNnVVYTA5?=
 =?utf-8?B?Z1o1SHJyV3lNOTJHeXBLRFRpV2J4Q0VFTnhYRkZqUmhKNjYrTXFlSVlYT1l5?=
 =?utf-8?B?ZTF6Um9sdCtwcnhHZVBueWh2TlUxOVR3SVNMMTlKYUpLaitUNldKVXg4Skto?=
 =?utf-8?B?aCtjOXUrMXlIWDNRenhhbVpLd3I5UUFxSkJpbndyQktVNmFCd2N3YWYvTHk4?=
 =?utf-8?B?TTBwem15Wm5LVHVSZkMrMkdScjloaDlPdmp4ampnWGcrYlBUazNYWFN6aE1H?=
 =?utf-8?B?TWFZTlc5QmVYdFZPYXhkRUtIYmFvalYrU09na01teHMxU1VZajYxZDFCR3hG?=
 =?utf-8?B?bVJaVmpTb3FYNDJtVE5Gd3BSUUtJQTRtQzZmQjB1amFCdTRyaUhaRUpreFBN?=
 =?utf-8?B?ZnlUem53R2czZ0lRM3QybXZyMFRWLzlaWjU4eEFhZkFWTElPNExjUHRPajRz?=
 =?utf-8?B?MW5MQXNHaEVqK05VSFllcGppWWpNMmQ4Z0FwdTc0eHFzai9nSUJZeEZyNERU?=
 =?utf-8?B?WDNDdmhseFlubmxRY2FjRzg1Rm9MbkhVbHhtNW9CWk9UejlkdlYrR0JUdVFW?=
 =?utf-8?B?a0ZPdmNXYmw2ZXQxSjBwQUtyamhsTnVCNmNxWHpBL1kzcUZ5c2NMRDJGajZn?=
 =?utf-8?B?elRCQ1JwZnpjOENpKzBVaHFXa2RqNkJNZHFkTlVua0grdEJMUUNhWnhDOE1I?=
 =?utf-8?B?SGJPTGtNL3QrUnVBMzAva2l0RVptMnJyaDdGbytJT0R0ZVJxNmZXa1krWUFL?=
 =?utf-8?B?U1BFWCtPZ3V5M2NFeHovOElTSFFiajRpQ2RvZ1RHYVJqVlFYemptb3BPc2Rz?=
 =?utf-8?B?REpWSVFLSXllblBJZlJieTFzMEVSQ3JMSzA0aDZUQ2R6WHFDT01hQ29qUDlv?=
 =?utf-8?B?VXBoM0UxYWxOc2tHY1lqbkhYb09OZ1VsaTk3WDd6dlRteGpnMlczSXI1R0tr?=
 =?utf-8?B?cDVoY1pSem9aYllNZ1lDb3YyV3c2QXRSZ1lTZ1BDbks5RlpKUEw3MnNNd1pC?=
 =?utf-8?B?MFJBWHFBSGFuSG4rcFlKMStwV1QybVZJMTdEdjJ1Z2N4NkhiMkp4Rm8rWHNO?=
 =?utf-8?B?bzlWeGpNU0dzRDZCUXF6SjVLUHRwTVJwcGNtUzBOTGRmam8wM2J1K05yWW1a?=
 =?utf-8?B?L25nMjRVZ0thRks1SmJTR05KNVFZVDI5T3NLaXZyVTdzVi9XN2xZTENtSlp2?=
 =?utf-8?B?RmJKZUpTekZqRTM5V1FwRFlkT2ZTdndtZjNFL0picHltcVJRZlE5d1BFU3d0?=
 =?utf-8?B?N0ZoVVYyYllOOFJsZEpqRXcrS0RHUlNRNHlZMDFMUmRLQ2s5dVN1THVmNHlJ?=
 =?utf-8?B?RDZCdXhXQTZpWmFVdzVHYlUxVnIzRUtqY0hCSGo4Y0Y2am5nKzhiRm1NaE1w?=
 =?utf-8?B?cXE5Z243YWRqVUR2VlNmV25QYXRKM25tZTdnL01lZmVOQk9ZRnBXUFZCdDJL?=
 =?utf-8?B?azkzZmZ4WU9aM2dRRkovQ2xkVnBXQlhTakhpa1FzVzhONFA1c3diYmp5OVQw?=
 =?utf-8?B?empFWnloZnR6UG8ralEzMnFOM0k5d1Zjek5qTmNPSjNzb0pOd0VadDVIYlpI?=
 =?utf-8?B?THZES3NXMy8wTnFlclF2aFVPQ1I2Q0VBRHZhWUJNdFgxNUJqVTlHQkFURTlN?=
 =?utf-8?B?NzZrdW9rK1lvRHRIUFk1TUR3Uk10cWFyUlVWTlpwNS9jVEZ5RDY0MGNlVUUr?=
 =?utf-8?B?bmRyLzVneEtOTysrNGNxRTNTNDlwam91L01FcmdOYzdOUFN4WGpUeDEwbTJR?=
 =?utf-8?B?SGxWZHVPSTBCYW9BclVuc1Z0WEg4cUNRRHBJNXRENE50My8zQUJ6RUFQdXgr?=
 =?utf-8?B?SFAzZ3BoQU05Q3kyMjY4WWpFOWV0SitwWE04cEZ3c1NXanpZV1RjWG00YlZy?=
 =?utf-8?B?UTAvblJ3RDV2N2ZkdEVpaDU5YStoTTh6ZVlRMFJpUWRwSXFXNktlWHNHSG5E?=
 =?utf-8?B?T2R2T2hTTzdDWm9tSHNQTG9aOU9TRTd4OW1vOWdnSnV5UVRtTTVGVERRQUpZ?=
 =?utf-8?B?MTRHZURUSU9nblNFWDIyZlVKYks5MkJZc1hwK1NRQnlzSXFSa2JMRXJDRUhP?=
 =?utf-8?Q?WzUy6uJQUShipcxxKKMMS7DE6CKF39YThYKFeXWWxOUin?=
x-ms-exchange-antispam-messagedata-1: 3iOo10cEGZzrCiln/uPkKvevO0AIdb3iZkw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <304D6E1F1DF80B4899665974BA06C75E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EpRRJejmNjyJDYgYiiDZXXQmab5L5PMFfBFjluJmjLTmZzmQPMQ4OicyjNHzMMaRbX3rKh31sY0m4dC4DB+PtQdEfaf7ZdznT9N1FeQF+YRti3on/DyL3Ox/FyJlB5vgiqsd6A7CmoS8U9z5/EWnuuxLq0YUSBtoihIu9OGJ5qH6KxDtySjqFfYBuVHQwpadEhGXYK0tagRENkIMJb2JwGSBVUotSxUH0U/wi2sklmUJMeVno5Hy9lDY8aJUZhlq3Wt46/XaYj1YROvPCGwZLD8flOokrOd4NUiWnWzQO03cqhtDD/r6NQDZ+wVeh7MZhhISBMn+5YdLkBQOEvxOYzDCX7ap0ot2QhVOIt2sA5FN1f0yLE2/I4VM0Z8IEX2X6E62zXl2Te5izqklAbJg9F52sCtIEdckiNzvZdflsP1RtVX4JxN0amGU3J9v+45EprTteW/YUlXx24okIy6faXsuvD5ZwQoHgErP8mhLX3gCUY61SywXNV8iWoezozU5bP9SxHCrWNXTkCUiY68NONH8isW/V5DrZHVu9E1yBP5ME/ASu7iXfSY3VjSSZs/tZwqvkH0gjOTGHbipnR1uRc53lgkabIi8CV30R8ahW6vuPTYk4+7vguhnQjNQEyhW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7807767-7c06-4669-7b45-08de7460316e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 11:22:42.7591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQoTiphgk9veESQayJF1Pl1AhGMoaJZwx/I+ZP7XXTtB5YkXlFXqvPHpzE3G8BUqwdVr0TNsSW1IeTE5OY9IW2HM71HfciupYD++ZGnWDiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR04MB9571
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21915-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fb.com:email,wdc.com:mid,wdc.com:dkim,harmstone.com:email]
X-Rspamd-Queue-Id: D0A05196602
X-Rspamd-Action: no action

T24gMi8yNS8yNiAxMTozNiBBTSwgTWFyayBIYXJtc3RvbmUgd3JvdGU6DQo+IEZpeCBhIHBvdGVu
dGlhbCB1c2UtYWZ0ZXItZnJlZSBpbiBtb3ZlX2V4aXN0aW5nX3JlbWFwKCk6IHdlJ3JlIGNhbGxp
bmcNCj4gYnRyZnNfcHV0X2Jsb2NrX2dyb3VwKCkgb24gZGVzdF9iZywgdGhlbiBwYXNzaW5nIGl0
IHRvDQo+IGJ0cmZzX2FkZF9ibG9ja19ncm91cF9mcmVlX3NwYWNlKCkgYSBmZXcgbGluZXMgbGF0
ZXIuDQo+DQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzLzIwMjYw
MTI1MTIzOTA4LjIwOTY1NDgtMS1jbG1AbWV0YS5jb20vDQo+IFJlcG9ydGVkLWJ5OiBDaHJpcyBN
YXNvbiA8Y2xtQGZiLmNvbT4NCj4gRml4ZXM6IGJiZWE0MmRmYjkxZiAoImJ0cmZzOiBtb3ZlIGV4
aXN0aW5nIHJlbWFwcyBiZWZvcmUgcmVsb2NhdGluZyBibG9jayBncm91cCIpDQo+IFNpZ25lZC1v
ZmYtYnk6IE1hcmsgSGFybXN0b25lIDxtYXJrQGhhcm1zdG9uZS5jb20+DQo+IC0tLQ0KPiAgIGZz
L2J0cmZzL3JlbG9jYXRpb24uYyB8IDcgKysrKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9y
ZWxvY2F0aW9uLmMgYi9mcy9idHJmcy9yZWxvY2F0aW9uLmMNCj4gaW5kZXggY2M4MDc2MGJhNWU3
Li41YTg2NDQ2Njc2MjAgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL3JlbG9jYXRpb24uYw0KPiAr
KysgYi9mcy9idHJmcy9yZWxvY2F0aW9uLmMNCj4gQEAgLTQyOTUsMTQgKzQyOTUsMTcgQEAgc3Rh
dGljIGludCBtb3ZlX2V4aXN0aW5nX3JlbWFwKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZv
LA0KPiAgIAliZ19uZWVkc19mcmVlX3NwYWNlID0gdGVzdF9iaXQoQkxPQ0tfR1JPVVBfRkxBR19O
RUVEU19GUkVFX1NQQUNFLA0KPiAgIAkJCQkgICAgICAgJmRlc3RfYmctPnJ1bnRpbWVfZmxhZ3Mp
Ow0KPiAgIAltdXRleF91bmxvY2soJmRlc3RfYmctPmZyZWVfc3BhY2VfbG9jayk7DQo+IC0JYnRy
ZnNfcHV0X2Jsb2NrX2dyb3VwKGRlc3RfYmcpOw0KPiAgIA0KPiAgIAlpZiAoYmdfbmVlZHNfZnJl
ZV9zcGFjZSkgew0KPiAgIAkJcmV0ID0gYnRyZnNfYWRkX2Jsb2NrX2dyb3VwX2ZyZWVfc3BhY2Uo
dHJhbnMsIGRlc3RfYmcpOw0KPiAtCQlpZiAodW5saWtlbHkocmV0KSkNCj4gKwkJaWYgKHVubGlr
ZWx5KHJldCkpIHsNCj4gKwkJCWJ0cmZzX3B1dF9ibG9ja19ncm91cChkZXN0X2JnKTsNCj4gICAJ
CQlnb3RvIGVuZDsNCj4gKwkJfQ0KPiAgIAl9DQo+ICAgDQo+ICsJYnRyZnNfcHV0X2Jsb2NrX2dy
b3VwKGRlc3RfYmcpOw0KPiArDQo+ICAgCXJldCA9IGJ0cmZzX3JlbW92ZV9mcm9tX2ZyZWVfc3Bh
Y2VfdHJlZSh0cmFucywgZGVzdF9hZGRyLCBkZXN0X2xlbmd0aCk7DQo+ICAgCWlmICh1bmxpa2Vs
eShyZXQpKSB7DQo+ICAgCQlidHJmc19yZW1vdmVfZnJvbV9mcmVlX3NwYWNlX3RyZWUodHJhbnMs
IG5ld19hZGRyLCBkZXN0X2xlbmd0aCk7DQpXaHkgY2FuJ3QgeW91IG1vdmUgdGhlIHB1dCB0byB0
aGUgZW5kIG9mIHRoZSBmdW5jdGlvbiBhbmQgc2tpcCB0aGUgbmV3IA0KbG9va3VwIG9mIHRoZSBC
RyBmdXJ0aGVyIGRvd24gdGhlIGZ1bmN0aW9uPw0K

