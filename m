Return-Path: <linux-btrfs+bounces-1606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767CF836BD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 17:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64771F23A79
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 16:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873BB5BAE9;
	Mon, 22 Jan 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZmAnTc1m";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GSfVC1Ke"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D446424;
	Mon, 22 Jan 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937211; cv=fail; b=lxXxbMtkDfZFHgeF43d3AysfvCCarme6Cc/1kRKT3bzEsMXNWuB7Tu5B7QdOinb6RD8L7mv5UEGmipjsGOd9by377m2ijKhFCmrLQZfeCbX5hNZ8sbBvFa/6U7tDToTxksmQQNXiqq+jo9KaCGWPVokYgz/nXGBgvqwYS224q84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937211; c=relaxed/simple;
	bh=/82JSyTnPeCPCWBEZTFZcFT1Jl55kAAxlG3jEmWth20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o4rKPgBt+TpjUdB9eNv5AN7dLrZOgkrj1KL5S281T8HzZvohjun0t814gcqxUEerXrXAZjh2NZK2AIVjCZbMY5PYz/Wa3YFx+SFecxXtEpue8iAf4hEwW1jO4uJLQ6xObCnLkoePk3lbnmMym9vwDiaCiqYzSlXSfP7efvgFWIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZmAnTc1m; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GSfVC1Ke; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705937209; x=1737473209;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/82JSyTnPeCPCWBEZTFZcFT1Jl55kAAxlG3jEmWth20=;
  b=ZmAnTc1mVibxJBP7bnG7F08z0eImQRVfRpBmhpo0HDDit501jV63udqW
   e1gtPEdlOngQdyxha22sNN8HyeEsSoWL/UP5ob7qlmvhosYu4tW6ke62E
   x544VM3BKpvTMptM6NlJ19u8waoJoMv7uGjRiMCKtXEOmhVyvjVAZeAxK
   hd69GhuUsH8TrSScUFQf1EkFrjkJfGPwNI1OV6xzrUiW1MyhmDl3Ar5PW
   nstBSzAqu4dHFod4GqkIj1pIKz75ErKBRjHLAlf5SbMtrAfiYGNlQ2kOY
   mh/mRdCkAQeCs2OKzLlqTAEp3J4psO8qGXCftDaNM17CYt1ete61oJe4F
   Q==;
X-CSE-ConnectionGUID: 8u2BcOXzRhmq7Y2adLLoDA==
X-CSE-MsgGUID: t9871ErxS4uaWWJPrVFQHg==
X-IronPort-AV: E=Sophos;i="6.05,211,1701100800"; 
   d="scan'208";a="7670516"
Received: from mail-southcentralusazlp17010000.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.0])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2024 23:26:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCCUPrvsqhnGzRVBU1K3/JgJrt1XbD+CkrWmTUAHqonAPX4TtrEZrJa5WnFlegEwYBraxPJWIShkrb3FqCsoO2ND8ToDAwnQYs3Ndqz3DqZijhInd/UAXbq4ORpMSLOdeVuAyA1vZjXd1iAGT1jZxggGSFjmPVKhDji/vdE6Fqe05D8HjSnm9uViWhgZ8QhgARHU0bxEgaUsnhW907p2GnluDS+54BaiMnvhI/Yzff4XwTJnU7I/V8xoBQEsnzKDSSc5a8X8Px49Vpl5n2inLmlq3cEPUzd5FtMCCJ5+6fRWTShPsUGjx40Qe+IRyFeUGBZjKAzX8Ehjykzljq2FVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuNuteBTSp942LyWlhH6xOUZlm98L6AjoKJ+StKVDSg=;
 b=Rfx7ohTAAVe/tvThE3sLY8ei7RbEMxqtx8oqE56eCKp0R3NVi7oWx7o6cKSsgixyUrOsWHcUipa8Y0bdsh5tgS51FeNzz84yFzSNwDCYro5Q+3JCy6+G9Hw/wUTe6vF/ZSh8UmjbBM6m7qi/wpEuPv6akwcKNwj8mGclwW/MMzgHzhEZ43488QoabmqKKZwGYOFzmIVMlsIXhJP4821wUXgWnuUQmyVD641O0FWUC0jH5r9UBc+zvGx2YtTXqKDqfwz1lVaEmU0Ucovl7H7BSbNJzh9+Eoiw1WXkLxRbXXvV5Df92PrXL2wjoRjh8z6mQiCCOeP0iawKY/D+IbB2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuNuteBTSp942LyWlhH6xOUZlm98L6AjoKJ+StKVDSg=;
 b=GSfVC1KemHKpSWLhBgAYJ11En/CtBz++fP1T6msQVyXA594ezOjtCokgKnHTyRisnboFSwuep8n+hWyK752rFTqIPnVe2hSCHf21d0zJxS9rIKnci9jkwBwdqxasYNCP67TnuX7/CFA07MHhyijmGD2lEdFFnOFAyJP5nl2HUD8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM8PR04MB8136.namprd04.prod.outlook.com (2603:10b6:8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.32; Mon, 22 Jan 2024 15:26:45 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 15:26:45 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: Re: [PATCH 2/2] btrfs: zoned: wake up cleaner sooner if needed
Thread-Topic: Re: [PATCH 2/2] btrfs: zoned: wake up cleaner sooner if needed
Thread-Index: AQHaTUFOSU3kvBJL0EyMMqqSJ1tHJ7Dl9EwA
Date: Mon, 22 Jan 2024 15:26:45 +0000
Message-ID: <mhprsf62tm4n6e5lhcujucu6ejfaomexrud3prqxlv5k6rwlws@q6gn2lsueoyl>
References: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
 <20240122-reclaim-fix-v1-2-761234a6d005@wdc.com>
 <x6bi4u2u65q37tde3s357lzhce4wglpobfgp7qgzhun4iadg3m@2pewiu6xuts4>
 <f5d54836-5edf-4cd0-88c8-f2d474368ea9@wdc.com>
 <k7fiky6xm4hshkr5q2xukfjndcseiesfanlpc4oozztvuyclbw@ftrhgjeicsfs>
 <2fa9112d-a72a-440f-a32a-199b5350b59d@wdc.com>
In-Reply-To: <2fa9112d-a72a-440f-a32a-199b5350b59d@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM8PR04MB8136:EE_
x-ms-office365-filtering-correlation-id: 3ea63925-de9d-42c5-95e5-08dc1b5e8b22
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AhzoKDiw4kiCrCBB5ow+mVCLlWzitZ2srAqtIuQj6/MsyWroHEzqAPzf+k8PFUKtvbHCWemYpRUSeyZzeBw/KmwgQR7T6UOXl6welt/fFmfy9K0q7V63hmmlEUk8hoyFjQ9AgjUTYUa+IHqxnaHWbjtF4S06YLmZpgGT8rpbskULRP4AFlA4trw8HupS/M7zrK8hFl8ApgZpG4nFusiqfkoELwCUfO1w+AD5KjraXH05gZLXD3TnlIMizM32DJKNGCkhEhUJrW1MP9fS6wFmjcD8CGSVf04Rvr3KNIcHwAublq72f3ayN0zkrVCMbd+pqtl0kMrOmggrgGms7M/nvwYt08StcSxJ+yQr9SH/FRrgZtaYDvOqUVNSqLoG50eo9p4HfUE7td3Yf8C3ZSPs3W7AUE66p1cBBU9SMg18ZqvcJe5GtNi+HhVnAm8RJLgIvw32fuuSdyyEwF2v+omC1CIasYGs2G8HmQhAPD+BQqSeQWN2PsDWXp1HAf1Cy78WgFxM7ndGDCylM60sBxpOSS18pl7mqfJFReAskrfVArrTdJLvIoH4zSWhzfPPI3I9+0xy/8696sakm2kUxwmG5bgTfpwVyPAu6kbXWXpGAAiZoYCAERzq4sJQULd/Hg/Y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(396003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(82960400001)(38070700009)(86362001)(122000001)(6862004)(6512007)(8676002)(4326008)(53546011)(71200400001)(26005)(38100700002)(33716001)(9686003)(6636002)(54906003)(316002)(8936002)(6506007)(91956017)(66476007)(76116006)(66946007)(64756008)(66556008)(6486002)(66446008)(5660300002)(478600001)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IAY2PUaRjZrFJVe0TReJa3Wod7O/pQcLQrSc3jrOsE5pT0ClrLWFKYVohzHg?=
 =?us-ascii?Q?k0nz3iq11MClq6mHoBrTGfWT9b6av6sREUwAe2Z49OkGQoHMj6ukuDDDRxnK?=
 =?us-ascii?Q?Q547vNmqKVg+yjrT+dEw3lObJ0np9lYIN7IOoaxWfFg8kGgMrWcD4NzQp869?=
 =?us-ascii?Q?9cTAAmdEsrYoy2EClrzBAukt6Uk+6qvzK2YQKKDPK2TyJpqZC6+RZ6AUHUuj?=
 =?us-ascii?Q?lSCaQF2bREm+coiOakD70z6G0dvrsd/qGLiXHQgFoe2EBxF5paVz37ErCS+3?=
 =?us-ascii?Q?b0EsqitdmW7qJ7cg8DT6HZ+68+3ED5uoCD9EzRFzEksLAhJAEL43sus7qSxb?=
 =?us-ascii?Q?vXiaCZjpA8fI07AvyD8ANl7y88oLrKGckY0zmCFZeEHu1bKpV5H1MAkKiPq0?=
 =?us-ascii?Q?Z/+K9YcphQ+I1/Kc8tWCZBkDD3D74XK5/bH9ZRLY3VN+B0n3a+ZN9TBYItg3?=
 =?us-ascii?Q?+xMT3g7cCEaFSNoJI80KSWybS26RnbWH6h5d93MFqO57c8VLE6xs7hTXZMYB?=
 =?us-ascii?Q?wcI1lgoerMAv+Dtfz3Mfo7pHbx2eo8boUBfB32ZyhZyDjgw/hppuAPo2jt8S?=
 =?us-ascii?Q?O2dPl7eHgw3kf45LF+B3FbPMKGxnxOVD4zdW7iEDnzMu5dtY5t8tsWygYnep?=
 =?us-ascii?Q?2v5jAZgmitk1TU31HKNrVUpuklrd4daPUwNb4nAoRAE7OhpFNxoLS9Kj8v3Z?=
 =?us-ascii?Q?faN3wQcXxH9F2KB1DP05CjdqGSQp7E1uvi5BrlIhzV054KhCJrc1EXaayhl6?=
 =?us-ascii?Q?C1bCNb6Wf7+XCHw3E01lyFWG5mVCbhLAv9bNFhh6r8Sm3OnvHaTwPJtlvcfN?=
 =?us-ascii?Q?s90R/eIHUT6LanbjBzNksfUskpH877w+3znSa/ED1hRNpM2NvHREiT54cO9P?=
 =?us-ascii?Q?oHq2RE8P0fIPVWrhoYWTxWRmiV6gJ6RmN15n0RCpGaaRgTyboa/ZuKeLIT8K?=
 =?us-ascii?Q?pQHn28xwa2sjdfF/TZlx8AnwuFM5DWiu8HbS8mEtWz19wGiaWRRpUGGafIoH?=
 =?us-ascii?Q?NpX5riR1/4vSETPFfbxoYOaIS1sBiamPOiWKK5EORSyl4lNn5vhffDp8UyZ1?=
 =?us-ascii?Q?FhhZvBE/v+uIpPHFeZYBeLJkUfSzUzUSjkF1FEyf8ew0Gl5s5GvwvGRc9NRf?=
 =?us-ascii?Q?exM4YzR6NUfjAFFu9LwmvLtXo287jEmZiCcFE0rHFcwmfIZ0VMsasCwIkudE?=
 =?us-ascii?Q?mIosvE3MlPXhO+vXF+A+OWd0GFTNaRPqrQ2zTtkKKMh5s0lyo+GxSyZy7UUV?=
 =?us-ascii?Q?3P/gLWNTKhyUFgmj6m+DqBwwChxNc03JHMc1tF7tVmmv3gqpKmJ1RY9shzNj?=
 =?us-ascii?Q?mfNR07AAzNHSQmvObuF+NLtaqG+bDUfr+yCJSK1FKaFOyVhbT60tlLa9Uvtx?=
 =?us-ascii?Q?g5NX2EIu2+AxxxPyPHnZ/Fl+G0FjexDWNUevFfNkKvICuGDHmqpv3XQ9Nmkq?=
 =?us-ascii?Q?2RJ5XR+uekodrUeaOiuJb+Qykk1PEro2YXEDJSJxVpt9lxGXKQuNysTA0GuV?=
 =?us-ascii?Q?k7f/ehlr/YQuHhiQv13K6fsizQVtpKd2E14BrHW45GC+isOPLB/XPquzJwT1?=
 =?us-ascii?Q?cBu6mvnonj0pCUowwqvHkawF6gE2QM9E9Bmm2vR7h5UFRlJhVOpxWcdX2Ajn?=
 =?us-ascii?Q?LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A0885BBA15E6D43A297583C8EF90403@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tRCx+HM+fTMW5l63VUx/WTLr1QSuCSmQOjkq12c/v2qBlPaNYpTK7cBghYAMlzyt5qyT+GD5LijzRyALH0ZGjkvPMbkMguMtM3vAtjtEywPUW3/+q/etYjdfydo0JTLGNyFsMtQLeeI2CNCjOUJtZw5g1M2HkrTTcGE172MDDJ4bmuozULNR2OBk/3OfIYqVPvbOItHIgsB9+QLhm1E2tpz81P2a4JJQW6w5EoBvkxlWIlxaJ3gIrkH0h79dlBAcdj/AtwIOC614/uwtSTWfjXebzM3rXoARluVvQFYTlFOO/hCzMmgddgQ3zK7mAPAV3TbZ13kRZ3L99A3PyuGQjpo+vTvXNdr68TPJeFl0oozLFZFFCaIGDKfwdY+IAiaf2OPyRGmiaqSlnxEaERVhMUdO0aWqecS+4waTXlJvcx7WfxmOcdL1KT71KsIlRl9D79Hp6nxm40QSIeAzrbEFZSv410WL6QfTjERykQ6blI2nQav5354yL61uNrnz2fWnvDtB8yCBy5KpAW9tOfKAoaULpZFZYhmdK6kS3m0cAcAm7oXr0kPEhmapVqs29cgv6papd0Ltd3uMXTGumApP//XhtJf0dmZI8H3TO/vI9rlJED1wEiQMeVvw2cRSMgzq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea63925-de9d-42c5-95e5-08dc1b5e8b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 15:26:45.4695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iifPGURNbp+0WzSjgSHCISD9418UGQqUxqvYGz97h3qxv6uLMB7Y15xrjpx/BfRCTj4oxoJmKaE9E5GudCHP2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8136

On Mon, Jan 22, 2024 at 02:43:03PM +0000, Johannes Thumshirn wrote:
> On 22.01.24 15:39, Naohiro Aota wrote:
> >>>
> >>> Also, looking into btrfs_zoned_should_reclaim(), it sums device->byte=
s_used
> >>> for each fs_devices->devices. And, device->bytes_used is set at
> >>> create_chunk() or at btrfs_remove_chunk(). Isn't it feasible to do th=
e
> >>> calculation only there?
> >>
> >> Oh sh*t! Right we should check bytes_used from all space_infos in
> >> btrfs_zoned_should_reclaim() and compare that to the disk total bytes.
> >=20
> > You mean device->bytes_used? space_info->bytes_used does not count free
> > space and zone_unusable in BGs, so using that changes the behavior. Eve=
n,
> > it won't kick the thread if there are many zone_unusable but small used
> > space.
> >=20
>=20
> I did mean btrfs_space_info_used():
>=20
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index b7e7b5a5a6fa..d5242c96c97c 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2414,6 +2414,7 @@ bool btrfs_zoned_should_reclaim(struct=20
> btrfs_fs_info *fs_info)
>   {
>          struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
>          struct btrfs_device *device;
> +       struct btrfs_space_info *space_info;
>          u64 used =3D 0;
>          u64 total =3D 0;
>          u64 factor;
> @@ -2429,10 +2430,15 @@ bool btrfs_zoned_should_reclaim(struct=20
> btrfs_fs_info *fs_info)
>                          continue;
>=20
>                  total +=3D device->disk_total_bytes;
> -               used +=3D device->bytes_used;
>          }
>          rcu_read_unlock();
>=20
> +       list_for_each_entry(space_info, &fs_info->space_info, list) {
> +               spin_lock(&space_info->lock);
> +               used +=3D btrfs_space_info_used(space_info, true);
> +               spin_unlock(&space_info->lock);
> +       }
> +
>          factor =3D div64_u64(used * 100, total);
>          return factor >=3D fs_info->bg_reclaim_threshold;
>   }
>=20

This changes the behavior. btrfs_space_info_used() excludes unallocated
space.

Also, if we calculate it with device->disk_total_bytes, it screws up on
DUP/RAID* profile because btrfs_space_info_used() counts the logical space
vs disk_total_bytes counts the physical space.=

