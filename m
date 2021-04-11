Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2308235B241
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Apr 2021 09:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhDKHwI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Apr 2021 03:52:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12184 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhDKHwI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Apr 2021 03:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618127512; x=1649663512;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qq5Dp7YT36LAqfZuRL1HY9v8VzQkqG5UTv+lZuIgvUU=;
  b=GkpV6UQR/1niEWw1CFl0OaLFsPsq6X8oFvGD2vQYWvU4Z4j5rR1njoKr
   HUJt+pMsddDmtn83sHma5jpe2h5QovGW005+5RbBWT9i6YCHaLHqizHsN
   TbIc6ybTEF4aqqKBuw5inL1/9TeRpo6UoXc7MO8cTZ3mnklDfLyF4O1kK
   NIjQMktQFx/fNb9Aq7xeilj/smfE6hk7sWh6s6xPGdiF/YPaFNApG4+Zg
   eYwhIy28CTLton5UCytkLvi4tpf9RudqZyb1kd2lu8eALSky3pkbBKdlF
   WVpK+LcAmAtEZJM9aiF/jZAfJgRZzezABwvqAb58XNmzWvlkHKsFgM1JU
   w==;
IronPort-SDR: 2vFRmu18NbLjIvf5le+GuohX30VeNIQ2JqXtitWMEduoSGlLuSzigXRYGFQYirlB8kudlqek/1
 nVO2csXR5AOst/ZTupB0AdmfIPyX781O27gkW2/XFau4YErDNSWCIYfeQhK0EzKwWwcfxhPrcb
 w9W5yfSu3m5J9xvAEgyFEgHF6sajyUfDuhMqVnqB6dn3LxxWHxHIDaWNhmEQIl4Q7BBdrmvzA3
 qrqbWXPlfHrZYSoQf5OvZm0eL/aU8qARrSIDfrb0h7Tc+8Zpx96x1LVbJfgB7b/QNvOKJ/hrRo
 Npw=
X-IronPort-AV: E=Sophos;i="5.82,213,1613404800"; 
   d="scan'208";a="164076270"
Received: from mail-bn8nam08lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2021 15:51:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxzG8d+fkNN9sw05s569qs+kVMvnXzYvLT6qPGmoi3ivQKLyFpK5Jt+E1Ak3Eq/SdvbBZ4C/4sXlWoxKAXueUEx/HsIsFu6uPrW7pxE08rFAGQqcKcvE52QRw+tLZq38XMMuftN92ACgy/glEb140x8xzPFj5mCfaBXwCOAcGkqBxoXYZT8eXp3ToqbLTpTR7VxxWO+0UgOg4Ok0MLYEAL0q8nFjPQdTrcjLSlXoGs8N/8PtqvgbPSiFT9Pqnlvpeb4myAvl10N4XWkJJid4K45JiN3NgSHU/zEWDmVdpj+++5AVXpz/34cTR8ozWv4Emw+ym2kmE0v2N7hXkx9GCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/JPHcC6wk3bqdAZA4NF1X5aDFkeZ7nN57ywTJJ0Sqc=;
 b=VLZNcWjxHmQHZMvEJbbRMSmV/oCyj6kWmOx72+GHXBmO9WYHlUzRdKtnmg/YSf5HMJLfGS+/WBAunE0yPCVjKJJlnPYV86hQUV8hsL++6JiIu5DE5YDv903Av3xoRdnoCqsqrYK4kHF864oWnQx67ZveKDtSdyvQgqoVYlOnI1ZMNGasj0eLLhXGVfeEFtV7gA8699g4VI/AlUHARS0D50yNGl1JIXVoUC4RE4t+lvCBOUGvSUOR3RWelgl5rOYpuUfz0E3ixaD6E50heXlogquyKz7gtMc1z2j+/KpyZGU8Jj+yPvOPMONp8PHyDZVc5oy2lI4NnhhoARINUC5rIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/JPHcC6wk3bqdAZA4NF1X5aDFkeZ7nN57ywTJJ0Sqc=;
 b=RCMZSqJarqKJB++gJjAwEMmMXh4LwGArM8ISM/h9B0M/Dyg6f97vT3mQfBqiY8P1dZqHOoI49DQuDp79YqRotzwhVeIA0GkBI/H84nzRpAuTRil72J0yzeBvz8fXI7AL4bcc7wLeyppop0o6QBhhJqTry5aoAqXUGl3gqs4G8zM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7320.namprd04.prod.outlook.com (2603:10b6:510:18::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Sun, 11 Apr
 2021 07:51:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d%6]) with mapi id 15.20.4020.022; Sun, 11 Apr 2021
 07:51:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v3] btrfs: zoned: move superblock logging zone location
Thread-Topic: [PATCH v3] btrfs: zoned: move superblock logging zone location
Thread-Index: AQHXLfJipZEskd+avUuSyUxYKReLmQ==
Date:   Sun, 11 Apr 2021 07:51:05 +0000
Message-ID: <PH0PR04MB74162D02874FF7A3571D6F239B719@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210410101223.30303-1-dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d6ac7e3-0a5a-4ed1-bbcd-08d8fcbe8fb6
x-ms-traffictypediagnostic: PH0PR04MB7320:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7320852DAE2F73C4D0225D0E9B719@PH0PR04MB7320.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: woNX7KOFNAwvb/1wzh9QKCm9/UYWrxX+nOhdBmhX7KC9KISuoY8RQ4KFOnYq07B8arGeXtE5BxIS8a8V76mJAh8QWnv9GHBpSfg4Q/6M2MYzvTdZKEi2xdBNFGcXch6IqHb/Q/8sC5s+K1MmHBonHyZxI8xYxsMPL5LRfQxNZlHg5HBrP0sD0Yc8JSedLc1y20N/+kQUy33Ma8m5+Lqa/3BjAXR0DTAQIhgV9VmMeSR4iduqIfTAle4FyPCAl19z96JwM0iQ1dioHzOcL/cjuFtZ3nrA5FP7Qh44nn2Ff9e3HZ3NlZUx6VfzFv8VMA9VJKErGmjPAAxemMx4UTaXBAtu6foqgZQ0BD67TiuXHbEsa799zTOr1PhJmFxU7vTDvTWZ3dpn5LZvvDmJeBZrm94rB2Ko6LwbGdKVnJpp6WcDJlzea5hHD8jjpGO0yL5t/O8RpyhkB9buJMciTx1WvDKcPRAjw0qpHAQ/dCe8hL/SMHCQfPQa2RD3v/+PavFVXNOw+yS3L6MVZVf6ItHvyRinnWnS56PX5gZLwIzsb1zV+3Z2bYmo/L2/z8sb/XdJGfmMscvELjTMs1Be311Q7pl1OQkLo2mzOTPiLvcq1Ag=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(9686003)(2906002)(33656002)(76116006)(66946007)(91956017)(86362001)(8936002)(5660300002)(478600001)(186003)(8676002)(38100700002)(316002)(7696005)(26005)(54906003)(110136005)(71200400001)(83380400001)(66476007)(55016002)(66446008)(66556008)(6506007)(53546011)(64756008)(52536014)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LWOlHmaMpJnIY6k2gVVc0tMf42hkWZVRgmLKzd1hS1gp63RkqQII2YwJhWxF?=
 =?us-ascii?Q?n+gxPPLfg7Pd6SwuazggC5NdtBaNqqF8dPGucSugrpPxH487Mzc2oMLSHr7e?=
 =?us-ascii?Q?/+AD7j7X1s18f4Qlwv4iRrcEqRyX3aTzQGqrwDxAdbnuzJjBYIsyaFuOl1/k?=
 =?us-ascii?Q?qWN8vux/bIxHOxtWrsJTM99SUbd4yl5CaVPqGwnTBEo34mscXGDOTa9HWg+O?=
 =?us-ascii?Q?yrBdo4XQWrWoEPWKzYR04bSS991xfJwL5b8OgBhCxUklp/JQST5gANgQ3d/H?=
 =?us-ascii?Q?udK0o2YouGQybz3Elc/NDGh9HFzuefXTaPYaP6r86/VoC7XJAM1gZky4n9Up?=
 =?us-ascii?Q?dBJ/+apgdS77jYrTGdsWdWmuO/gPhCFGS7ZSnQcO4C8c0FTpuBYHCqrQ+3yt?=
 =?us-ascii?Q?+Pi8YfnUdbrM9j0oCrJEDtzaIRo1ljOVBCk+lASLoAsEg1vTNKl1++hKPP28?=
 =?us-ascii?Q?Jglfd85+6tvnWvMDXKVBylHvQw2G3CKkK6BXbPR15/Zxo+JX1D0KQswkOreQ?=
 =?us-ascii?Q?uXrLWYcLrEDyF3n+l/ujaxgyg30Uo+IlqXYO2mGuaqpL6h3SN2vcKhgF+qEN?=
 =?us-ascii?Q?MhpsAyjtJECKFDCD0HQHwLDKcCMksFn9Be4TWfnGMg1+HYrr/0pLrj9gFOWz?=
 =?us-ascii?Q?epyhP7G9r+v/GOa1dLqy5RBQIqAeLXUo4oVCy5uILXkrxmJFcnfZ7M06dtzc?=
 =?us-ascii?Q?Ky6vodZaKrDc8IK11cK0Q3l59jsYhFYf/3ymRQvK6SSCVOEkJYdOuh0hU3eN?=
 =?us-ascii?Q?g+NfbQXdusTow9WetOW1gWmEDKJWLcBKbIvwLyMnOeAeArtSus1QUiD5npi4?=
 =?us-ascii?Q?FaYPHdjisDMqcqdORcdifTcs56bU9GGdrMicxP0mTWomqZ2bM8x4czqUvfAY?=
 =?us-ascii?Q?LY8HCV8m91Frl7tt3uVlZRASNfM7177VV+UHVq0fahNzK5uqTVvgg0D6CaGV?=
 =?us-ascii?Q?I6XDRWAPTQT4kzxmZdfKO3cj1KQOmfMxx7mPFJpkZzgh5/khuoRZxvamQloD?=
 =?us-ascii?Q?tmq0M5I+4sVXWIvZJRirCG68H1uNd7ey8N2fczN3MfoVlMzTf0g//JVSP8kv?=
 =?us-ascii?Q?5h/RxGcF/CzMjKgG2M4gDx2q5fEgP4HHabCH8LTRET7EGqNfp9zUBfgW0GCt?=
 =?us-ascii?Q?m/Z3Ohi19BUv+mQAj+yatUSpBdkp5kSBostDCtpI6Si5A8LSDqx1TZSsh8bj?=
 =?us-ascii?Q?Qrf4IyVvSPBOxubTAXXjDLP3vCgBOGwGoakFXRabdqTtHjz4VK/2PbjAp1eX?=
 =?us-ascii?Q?0dfSWzVVa4GuhcQlonPgUImAN/+6hSFtdmEV+7FyTzyb89MDSBYeJ77IBTXJ?=
 =?us-ascii?Q?Ul5qpq5oywuwOl2ru0wQux4fRw7C67cJt5RfVxBBj4F/kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6ac7e3-0a5a-4ed1-bbcd-08d8fcbe8fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2021 07:51:05.6355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l73RQ/LDSV01Bz5sXHVI+Hy0u9QDk2gzSDZ7FzkTSJAWgl0OSl0cNVkYX8lMEy3w0vuixo0H3QfPiwGPDRF0ZSaRTsJbXO2F3w6a+T+RZNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7320
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/04/2021 12:15, David Sterba wrote:=0A=
> From: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> =0A=
> Moves the location of the superblock logging zones. The new locations of=
=0A=
> the logging zones are now determined based on fixed block addresses=0A=
> instead of on fixed zone numbers.=0A=
> =0A=
> The old placement method based on fixed zone numbers causes problems when=
=0A=
> one needs to inspect a file system image without access to the drive zone=
=0A=
> information. In such case, the super block locations cannot be reliably=
=0A=
> determined as the zone size is unknown. By locating the superblock loggin=
g=0A=
> zones using fixed addresses, we can scan a dumped file system image witho=
ut=0A=
> the zone information since a super block copy will always be present at o=
r=0A=
> after the fixed known locations.=0A=
> =0A=
> Introduce the following three pairs of zones containing fixed offset=0A=
> locations, regardless of the device zone size.=0A=
> =0A=
>   - primary superblock: offset   0B (and the following zone)=0A=
>   - first copy:         offset 512G (and the following zone)=0A=
>   - Second copy:        offset   4T (4096G, and the following zone)=0A=
> =0A=
> If a logging zone is outside of the disk capacity, we do not record the=
=0A=
> superblock copy.=0A=
> =0A=
> The first copy position is much larger than for a non-zoned filesystem,=
=0A=
> which is at 64M.  This is to avoid overlapping with the log zones for=0A=
> the primary superblock. This higher location is arbitrary but allows=0A=
> supporting devices with very large zone sizes, plus some space around in=
=0A=
> between.=0A=
> =0A=
> Such large zone size is unrealistic and very unlikely to ever be seen in=
=0A=
> real devices. Currently, SMR disks have a zone size of 256MB, and we are=
=0A=
> expecting ZNS drives to be in the 1-4GB range, so this limit gives us=0A=
> room to breathe. For now, we only allow zone sizes up to 8GB. The=0A=
> maximum zone size that would still fit in the space is 256G.=0A=
> =0A=
> The fixed location addresses are somewhat arbitrary, with the intent of=
=0A=
> maintaining superblock reliability for smaller and larger devices, with=
=0A=
> the preference for the latter. For this reason, there are two superblocks=
=0A=
> under the first 1T. This should cover use cases for physical devices and=
=0A=
> for emulated/device-mapper devices.=0A=
> =0A=
> The superblock logging zones are reserved for superblock logging and=0A=
> never used for data or metadata blocks. Note that we only reserve the=0A=
> two zones per primary/copy actually used for superblock logging. We do=0A=
> not reserve the ranges of zones possibly containing superblocks with the=
=0A=
> largest supported zone size (0-16GB, 512G-528GB, 4096G-4112G).=0A=
> =0A=
> The zones containing the fixed location offsets used to store=0A=
> superblocks on a non-zoned volume are also reserved to avoid confusion.=
=0A=
> =0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> Signed-off-by: David Sterba <dsterba@suse.com>=0A=
=0A=
Looks good to me, Thanks=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
