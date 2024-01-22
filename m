Return-Path: <linux-btrfs+bounces-1602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA808365A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 15:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50021C225F5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 14:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC7C3D979;
	Mon, 22 Jan 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JBKJDPpu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C937uXha"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAF63D966;
	Mon, 22 Jan 2024 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934395; cv=fail; b=Z3ol/eUhTIUhUc6upg+6gbDhPTRn3nGWu0k5+GkAh6aL7NTA+NZOSxmHOm+9JemT9xZS9y65XuKm7ovy64p78GF1TDsNu+kSxmB2yEXlqkGOlPNYb3tkb0c6LjBexlpE5nL4h7+lRFLNV7SQRiUkK5CH/ufoc5g/fP4/rB7ty14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934395; c=relaxed/simple;
	bh=7j1DmMIbDVXiglJ6TVuarU69JVH4CYjrQAoIl+2kMkY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dkycoQv2juroX0KWcrs7XlfN3onCRgrnar6/66OpL5Qcb+t8xLBuy8hxszG77+4L1uXmkgZKPqVTwY6lOswVaS4k51e4GU754vmDaWsM0xpfXfodmI6ch6w+KVZ1x3sExbh/26OLd1HFXprKGLJeUjJB+170W8UrNxgH11grlmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JBKJDPpu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=C937uXha; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705934393; x=1737470393;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7j1DmMIbDVXiglJ6TVuarU69JVH4CYjrQAoIl+2kMkY=;
  b=JBKJDPpuLF9j7X5tETlbt6aXotdXWwluyThfkK25/IU2EQix1eBcDfGa
   SbORnx5yXBrQJsH1M7eJSa/EizxYKoV+C2UIAAnQRCGhv2FTWbE7eCccH
   sN1mrFsFKEedsGGjQrkYcCP/PL8Y67gpwYkmvYHSHAVsCXrist7NF8o4R
   FlNas9jrrVUAzcoPu/UFv34KoqFAd7hkDtI8HawRPLmTXIk0GYxnR/Pjx
   wtFxlyoDwRCA2k5b/Co7I8WGuYk1quJRYkoykz3JvfWJ10QIZwWJlqK4B
   nGU83hOUk9/0unTUt6OgasSsJhpZfsHPZ87U0IIR9WfokOOqhyf0qtuyO
   A==;
X-CSE-ConnectionGUID: QUFKmtRASeG68ZwQF9hv7A==
X-CSE-MsgGUID: TZSgwDxOTEqFCPHLZTCTPw==
X-IronPort-AV: E=Sophos;i="6.05,211,1701100800"; 
   d="scan'208";a="7168433"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2024 22:39:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeF67e2OTReIAsIHeOWM8YpR9ZAvGScU1ZSM6Gt7bZsuQysbsgiIhssXdm/SffzeJf5Xuu9RtxUcLy/cI53NfEnt6wW8NfXrPFQzzSvzjYEk2MwR5VJG4ZAxslPm0oM7XE9TtqwF+qu16o1G6E6hGfX8v53PKzzq7rOGVpST419xYNkGXz2EhoBXXrcHnDSl14isQ4A98BAPAq/Oyy1sJY5OVcRuzVieEfQcxldY+TexKsdecaaoBw5JXCDvfcJoqCzf/w6L9ZWsySMnwOPn5Yf0toyPF5LJx1s/p01qi77eRxw7cBw9bDtKG9QVxnVn/X+5SkW5//X7trKHgJui/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awsjmm8b5a62EZglOubEjDvIOS7RTOSZgU2W33Vnt+E=;
 b=Tv7VUuCM2Jbvi5Q/H3txXMhfsFPF5IiWKSXHjsZQxBa3rzM7iCZrNHbvje5A+zxqXEMzS7lLc9fDgS7DiaQ3emqqZTUrawK95lumA8pcTGkOVIQS9Fj7ljnTAuWZ8dkHdmj+tyOq5h6R9VIBRZCnoffuc9IjiwVZW290IP8+pL4HJ5Sz4BfjVGtJqwJjpqqpG5gPXQHrhFnjEtHfjftuY8+UVKhIRBBYFn6k0tNwT0bUut9RCRuAlQ+3E9PqzC+PbxND3tD0KMwFpZw9eFhgPr3C8MljAwzESGw6e6kEXW3GJcfaQzou1340Z9VPgOnr44Eax01deYRHwgKWPxPiWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awsjmm8b5a62EZglOubEjDvIOS7RTOSZgU2W33Vnt+E=;
 b=C937uXhagMs66XW+8STkfXDc8lvJFDXGfvOVzKEAK35FS7DWuvu1tw+D0MNFrcEiICynp6WqHJLCTH5tZluHQ70VweehNzlfxAlDDfFGxRu22O5l9Lj7bgVLLS2EeX+WpXNepn6d9LBLR5SRwZUfEiKzr+zUI+SvkWEEsjEcyNA=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN8PR04MB6274.namprd04.prod.outlook.com (2603:10b6:408:df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 14:39:44 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 14:39:44 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: Re: [PATCH 2/2] btrfs: zoned: wake up cleaner sooner if needed
Thread-Topic: Re: [PATCH 2/2] btrfs: zoned: wake up cleaner sooner if needed
Thread-Index: AQHaTSDvOd+kWBN8wkSOr2ka96SkX7DlwQgAgAACYgCAACQAgA==
Date: Mon, 22 Jan 2024 14:39:44 +0000
Message-ID: <k7fiky6xm4hshkr5q2xukfjndcseiesfanlpc4oozztvuyclbw@ftrhgjeicsfs>
References: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
 <20240122-reclaim-fix-v1-2-761234a6d005@wdc.com>
 <x6bi4u2u65q37tde3s357lzhce4wglpobfgp7qgzhun4iadg3m@2pewiu6xuts4>
 <f5d54836-5edf-4cd0-88c8-f2d474368ea9@wdc.com>
In-Reply-To: <f5d54836-5edf-4cd0-88c8-f2d474368ea9@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BN8PR04MB6274:EE_
x-ms-office365-filtering-correlation-id: 60463a25-2be1-43db-1d88-08dc1b57f96e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iPnTA3CJw375loRA8Zut1ZueNkrCS2/D0PX8KXEDLHbUTxY8802g/59J4kDfcYSruTYwxQi+jLfkF+94rit2TrHhur1KfJrNUrkbF2u/OFSPQ8Uxa1NG33FzojLFBTGr/rBzNmVDX4HYTTx6JFhyDpAZnYu9bAD9EQK8+2owcyNifc2YUhBrK9rs6pq3i3E0fUnpG6BIiFYl6DCuHKAibL4D2ZGm+FCwEy6L0zsO+FO4ItRnDJJ3J7xsq33tVmybTmndbc0h3uKz/YMgUAj7fIipM5iK1ORLL/RwagrKXK/TB+LByT6uGc0onTmQFoAr82HsfbNFMkShxJ1ENFbWAugY1zhGvxRpq1dukUIrLReltsCFuPaCk9EY64/Pcei/6frOEgWGuSY5ZreYJNhbRT3F2/M/+6rW6EidA9esoJ9ktFA/cb/XWWIn3L608rAD1NVo4QI5R+Eol8Yj0InIjQhgZrBOhhyMaDjxdgVHeNCVJlrKsTtQNHPwXbvZJ4asyX7mbQqEZ83s8n0Xem67XUICEY011/szamcyP0Veysek/PfSEoYXTmUuXKekw6CqkCbPdnRMcXzK9r0mjWUvnC6Tn4UmdKFIFo9xtRxKv/W/9AX9o7GRsLK5BRR2S3FK95BZkYSKsAPi+koN0CbcfA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(6506007)(71200400001)(6512007)(9686003)(53546011)(83380400001)(478600001)(5660300002)(2906002)(33716001)(41300700001)(66556008)(6486002)(6862004)(8936002)(66476007)(8676002)(4326008)(66446008)(6636002)(64756008)(91956017)(54906003)(316002)(76116006)(66946007)(82960400001)(38100700002)(86362001)(122000001)(38070700009)(27256008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5oGYuZp/En91ODKgwEHIp9U1dJ/FLaJfAV28KiB97b6osGsLkZRFLn1etyqe?=
 =?us-ascii?Q?LxEDfNFLQ3sj8GEAk7JPBu917OshCQoq6iV9yEeg+k4QvrXjtt4c5BOMXZgJ?=
 =?us-ascii?Q?CkEss4E9mrZ0uuBC6HLBLH+C7f04FLgubO9O1hWgc2XzrehTzCzX5YYDlxMe?=
 =?us-ascii?Q?PjJ2p30fASZGQfg+6UOCjHIIBdcXyfGPBiSRGtn/da8T64PmsQhyVpO1zRhI?=
 =?us-ascii?Q?ZyE8NNIPlA6IW4AwFtHPAVyHgmxUpPuuKt+6LWAp9T9CyZc0yzF9ceg/zlTM?=
 =?us-ascii?Q?lk25y1IZ7OMlNmI1LMpGzdeEi98XcM16ml0KXQhXq38mjXoC/k/QPZMKYiKB?=
 =?us-ascii?Q?RWQK6GTMzZg34zoL0C9/1c152px8KPLiIqfIJeseLR9NNv0xV8TWQ/+bIYb3?=
 =?us-ascii?Q?SHXCetCIpQ1TIBfj7/rGbnU6dcyjLdSUNKFAAtJaxjlRsDDdMDHKfi140Uyv?=
 =?us-ascii?Q?VTDGoLzbFSz83m3HT50h/WwT11RYaFYhUhYDARR5Igitsr5/InDbKrqWkxF0?=
 =?us-ascii?Q?DebYIPAHhHcIVDKP+CbhnrQtG0nV2CHRSek4rnJYu0KByHyE9lSZyEITMn/+?=
 =?us-ascii?Q?jV2iMP5TRTBEx2CEkfIjmPBdnITkvn/fYrD0nFu+wwC9jQnSEnU8MbZHVSFl?=
 =?us-ascii?Q?fXxyH3LTlipADCRDtRUJsc+ap90t3hW1ebxurVPii7spINmbXWcQHS+k6Z8+?=
 =?us-ascii?Q?ZonxEEBJyyD7Jk0TqI+/Eenp0qIi8hCBZhweRjrQM9I2KpWZiXZAhA9VjF+w?=
 =?us-ascii?Q?5d9/Ap7MI3NW+nulIjaOCOVGFuWNF/t6av0Q1u0Z3GlhK27qcpjDmNiVv7z4?=
 =?us-ascii?Q?Ksqy/H86cTGJYIwBD27lmvVfMVTkqEmLpROzy0cDOCJjfPe171wk9zXubgN8?=
 =?us-ascii?Q?AuaNJq7DFZBe5vIJXU6sJ+XX7auOC3u3du7CBuMXVFIoqwze4XjUmzvmI01Y?=
 =?us-ascii?Q?W2uqDSvIL4UkDIoauBd15qzdrZXSM8tRM/Tl79EAJSI4HXJ36ruhLMitXwSH?=
 =?us-ascii?Q?Jcn7HV6ELdEwis1n2yAdIBxhAqJK5g0VbnHe86FClLauqpstd3Gq0DdKhfy1?=
 =?us-ascii?Q?QQi1TLaLOeksWjvTKTIU/2BVRVyvZj4ru9jSgbjExU1sVhi70kCfXcdIt/Si?=
 =?us-ascii?Q?0RYPZdthnHVXRpGOSxf8R1EEW4m6Aeen6o6jKUrAjVYwoJRJFImzsBAcKHTK?=
 =?us-ascii?Q?L5tMcp+KQ4K8TI42Gxse0IllTisFJ5KddEOf1Ep3RYIuu4cYf6dliCy0j+6h?=
 =?us-ascii?Q?sKyKjicf2bB/IM65/G3Vjbvta8+mYc6ceM7vRQc45JFabs1aN/bPhlfLJWFu?=
 =?us-ascii?Q?yk2HFm/h2IDWUE4sU6oA8qlVxN1M6ZoGBVzg7Sa/9dFqpUTj8U1JaE3aWBay?=
 =?us-ascii?Q?mGLsstt6h9wnIeEDLkZyWcLeENQ8aLPN2QNscRPkkJOLGzfmVYPC9/LYRvFw?=
 =?us-ascii?Q?4AEw5FMHsnPQuMOKWYSHk8DLdZYVgMgIb/V1c/sVr0a00uR+XUNMz7QayHQP?=
 =?us-ascii?Q?9hJhCgRfyJIrB4h8InKR637VcOdzVT/tHAHmFdbO5PLUnjwEujAAcw7+bc/8?=
 =?us-ascii?Q?jEJSah9gvD5LeVz+maTH3r+OMypFVPhB1TDIWBc6+HqvAPcYYqG/wE086XhR?=
 =?us-ascii?Q?dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE37F9CF087A494D845CE5C5C7DCCDFC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gFdW/8O9jYwjMd6GIuK36rzkj7DuVt/Cu0xHffwIZQfJmaudJKneuelun2RDiNg8e6b/MZACAMOkbtN31WNov8EEYsUH/fQIyzy7pADE5IQUCRws6PWwNMbXhTaVJDZigStVo02R99vGADDCovKvRQ29Uj7/Ut7qmo1Tw0FDkxbvo5pZRS+5aQatc3cKoTLkYL/QORJBTiqyFSU3Neh/TWGPKSlJ/tqn/s3ahB4BkC7Whkw7Q1En71ewbbeby2/yECDb7jPM76zV/e0VuNMMP+HU6Xm0RYZijzT59HBJ1lzSXTSK64qMmzeqIRcqqAnGAulTeZIxVkIrzzHkxfUPqHF2uphqIKPvEx2VNkguF+EnvZ9HGs0UX1L1kEvsOd9PCOqJfFcpxhxp/vuy8SCTVRQX1sUKqJHH7LImYiF/hBllEmAZBvEq45CM2tDxAXc57/MWLFiHD0isH0PfJztx5FVC8xTXYVZr+xQePOhZjnub6P6AvZuus0jF9H0mmE/WQleoWYBxkr+vt5VCuyt6U31aCCxcppgr534XpJBoZehJXCpzsuyCUb7pr8SqIBHvmvQV/jpew8TInESe7PFx7qL2qwxxQ/8NZ/baddXtbxdQsZYduWwytXWCAMNPiDHe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60463a25-2be1-43db-1d88-08dc1b57f96e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 14:39:44.0375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z16C9ZBqcrJtk+V7R3aHfxoqlpQRN0yFm21DtWKaFwJfQ6nqwT3xi45H8TVh6lb9HeVFDWKjr0N/oz/SYNe5eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6274

On Mon, Jan 22, 2024 at 12:30:52PM +0000, Johannes Thumshirn wrote:
> On 22.01.24 13:22, Naohiro Aota wrote:
> > On Mon, Jan 22, 2024 at 02:51:04AM -0800, Johannes Thumshirn wrote:
> >> On very fast but small devices, waiting for a transaction commit can b=
e
> >> too long of a wait in order to wake up the cleaner kthread to remove u=
nused
> >> and reclaimable block-groups.
> >>
> >> Check every time we're adding back free space to a block group, if we =
need
> >> to activate the cleaner kthread.
> >>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >>   fs/btrfs/free-space-cache.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> >> index d372c7ce0e6b..2d98b9ca0e83 100644
> >> --- a/fs/btrfs/free-space-cache.c
> >> +++ b/fs/btrfs/free-space-cache.c
> >> @@ -30,6 +30,7 @@
> >>   #include "file-item.h"
> >>   #include "file.h"
> >>   #include "super.h"
> >> +#include "zoned.h"
> >>  =20
> >>   #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
> >>   #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
> >> @@ -2694,6 +2695,7 @@ int __btrfs_add_free_space(struct btrfs_block_gr=
oup *block_group,
> >>   static int __btrfs_add_free_space_zoned(struct btrfs_block_group *bl=
ock_group,
> >>   					u64 bytenr, u64 size, bool used)
> >>   {
> >> +	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
> >>   	struct btrfs_space_info *sinfo =3D block_group->space_info;
> >>   	struct btrfs_free_space_ctl *ctl =3D block_group->free_space_ctl;
> >>   	u64 offset =3D bytenr - block_group->start;
> >> @@ -2745,6 +2747,10 @@ static int __btrfs_add_free_space_zoned(struct =
btrfs_block_group *block_group,
> >>   		btrfs_mark_bg_to_reclaim(block_group);
> >>   	}
> >>  =20
> >> +	if (btrfs_zoned_should_reclaim(fs_info) &&
> >> +	    !test_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags))
> >> +		wake_up_process(fs_info->cleaner_kthread);
> >> +
> >=20
> > Isn't it too costly to call btrfs_zoned_should_reclaim() every time
> > something updated? Can we wake up it in btrfs_mark_bg_to_reclaim and
> > btrfs_mark_bg_unused ?
>=20
> Hmm yes, I've thought of adding a list_count() for the reclaim and=20
> unused lists, and only calling into should_reclaim if these lists have=20
> entries. Or even better !list_is_singular().

That sounds reasonable.

> >=20
> > Also, looking into btrfs_zoned_should_reclaim(), it sums device->bytes_=
used
> > for each fs_devices->devices. And, device->bytes_used is set at
> > create_chunk() or at btrfs_remove_chunk(). Isn't it feasible to do the
> > calculation only there?
>=20
> Oh sh*t! Right we should check bytes_used from all space_infos in=20
> btrfs_zoned_should_reclaim() and compare that to the disk total bytes.

You mean device->bytes_used? space_info->bytes_used does not count free
space and zone_unusable in BGs, so using that changes the behavior. Even,
it won't kick the thread if there are many zone_unusable but small used
space.

> =

