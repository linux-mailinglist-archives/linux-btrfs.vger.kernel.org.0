Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1CB3FC7E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 15:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhHaNLg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 09:11:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:20738 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhHaNLf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 09:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630415440; x=1661951440;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BCyv99+NGWuavJAZFtdvjFJHDLi2S0FMO/3JRKsfEtA=;
  b=UQjpp+ATDr6HdBNKR/pNSfN9p5V/tVU783qzGAfKblNpEFvlu6c0iyuG
   5HOdfJJElGIDeHGd29lR9bVUTjpcGimONbR4RVRcg16JSYjuDb38r/6kx
   kFdHQRsDhn9wCr7uyJmdKhAbPVL/B1L0FkP51SZ0mUA4nXbh0UObF//3w
   6TzBNUyARIADT3QFt230NJmovz3UMyLNubtzHTDTtoWIj9LkzO8qXmtKY
   nUc1msQTDwWN2AgrayxXG+3xpE6EBHg2qFs4JyrtVlAI+4tO78/HhnF+a
   iMlDcofVszhpv5RP36YvpDWA+W+XvqSutliw9qYcZ4xdbE+cfsrIWLw4D
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,366,1620662400"; 
   d="scan'208";a="290452064"
Received: from mail-dm6nam08lp2048.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.48])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2021 21:10:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfKCFOps0X0TJHwV45XEusWffYYIvgr10jeGzsI84Vx7yKMAok/ZDwpdDo68vKXWRegG2eRfIzu1R+986qrLqgxim+3JQL15aX1kNAYjWfCQasoG+xJWY9jzTp/Ot6R2gCGyVD9SW+/gfFSRm4f7TAlOzjDsn9b4z2jwDNTFQ0xlbzIUcJaMotsQdd13Dc3+uwurMcfTX4QhLAzJz5S03v9KLi/IPSy3TwIrJtx/u5gR1QzkZ+TrqKMAAJ57+fhW6/8aS/RmiOhFxf68YgaDNc7TRDY4jzpJ5NB6JPMkkgvfyoM+iuUHx5oV6rXAvGERxEHlijw0OZlu7KFlPeyjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7ckLiSJQPgs+QxlcvHcqFLTUhUy4EHAiDICLM77r70M=;
 b=mlU92wbiTTx5Fuyg9rZXn03m8Qru5NSLAXroN/M+DcuD32erUuXKx/PLuBl2FR8JL0hTTFae3GGbedvV5ZQFZiDlva9XktiUfTWgzbBq6eeqLxDXjXHiVftJM6aZS9h1lK3z7TkgoKO8R58tEOwFCrf+JzFb7Bmd//OdHA8VzSzI5xldCP9fxb5K3lUCXk9RrP2ZV5ZTC/tIG3l4fUJlxTMYZxZotA3DDXfhM3F/b1EMVtP/VdCrL2Venk0H9sByRg+bFZP0um394lJH2yW9QFFsVkaoJJ8nQ37C55TjGHFTK5gXD0kacndjvKYCwewDf/k0CLPe3jap2KNVUjI8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ckLiSJQPgs+QxlcvHcqFLTUhUy4EHAiDICLM77r70M=;
 b=e/hAeL/as8V5eW6IKxfrsgI+YxWW216+LNZhmfxoTotugct4MQF2w9I8atS/4oHHeB8nyJj3nKhoVAAcELLlT2R0E0iRIaazztnHEJgBYc2Jl2g06ZNJGbOUDtLV6PSQ+hZamIVea6zNRtEqKUlu/uwasrsA9MP7wL6KiXT8q1E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7607.namprd04.prod.outlook.com (2603:10b6:510:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 31 Aug
 2021 13:10:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%4]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 13:10:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        Jingyun He <jingyun.ho@gmail.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: btrfs mount takes too long time
Thread-Topic: btrfs mount takes too long time
Thread-Index: AQHXnARBiuLsA3FsJUWR7RlaxklqeA==
Date:   Tue, 31 Aug 2021 13:10:38 +0000
Message-ID: <PH0PR04MB74166604ACA14137484EA6E59BCC9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
 <ce0a558f-0fab-4d52-f2d1-1faf4fb1777c@oracle.com>
 <CAHQ7scVkHp8Lcfxx2QZXv2ghkW-nYpiFGntyZa0Toz2hU3S-tQ@mail.gmail.com>
 <b0feb23e-4a18-efd7-eeaf-832ef0cf6860@oracle.com>
 <CAHQ7scUiNLVD_4---ArBet-0DqzfmmH5Y9JgQY0grYrUv8yhiQ@mail.gmail.com>
 <c2d2a244-f77c-e0a4-d266-db011fc4154b@oracle.com>
 <CAHQ7scVOYuzz58KcO_fo2rph44CCC46ef=LFVZF8XzoKYq27ig@mail.gmail.com>
 <250cfece-1d7f-b98a-b930-36baa34b8b72@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c8b1875-567e-446f-ae7b-08d96c80ba78
x-ms-traffictypediagnostic: PH0PR04MB7607:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7607CBE73B449708C4B86C4C9BCC9@PH0PR04MB7607.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fofft8RyVTHVCb/3WpfXr+5rESUSvlIRTEVLUbhWTBwUCq0HXHrEaTPXvP9hFPJHClgCFMpwTEQU2xhnQHWluVP69SjTn0mzKeEM6IQW5V/fNIg45/8hyCtYAYaEkJlZOThTn2T4sLw50S4Kw4z4lYM3UDbothwM7x3lUMy3B3fiPNgZqsFNyW0VQqprAOVqSEd9u4XpgsnkRRhMUs3bowiTWCJV6QqyjZ6k5SAl0RgFPASkySK2UKWKA+rVw38gW6LlOgbcvZOVlG4yKm/Ws8/5CUbbjxswe3LQEp3cO4mcVaHX0muWVpotFu24MZ+A6ckG3PgM3KhWYHL8Tl7iMPn+zNzBBo8VZrfYW3gbcJvRmTMFSmDxUys42DzcrmHacALYdtHws8e6ZKrAhSHF+B6D6U2p38v3Pv3WCyRp1CFR7EkSr/wScEkE31pu45Pvu+ZZEpfl3jrqgR/CfVpoU3mCpNO/Z3r8rjWRATxOEMf4XydLIS0PY86ELlZGFn5p6HO7HGZ6wwGW1Px4c+SwDRobeVrsgMjycmWSCurpJMZBhucivFDYYhqvmuCoOs+uk9qmCtl8zGo64t6eb8rUS4Q/O96i/3042jggYuZEXxtTquOujWz+SrppEkVVPDQ+45Q/BNkUwwDHitXxCOTHkaGEqTA7yCuzKtUDUtcBVaO6u2O1flfdJyfNh8sndx7wsg4cychO74GbrSr8kpy+bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(4326008)(66946007)(71200400001)(6506007)(66446008)(76116006)(53546011)(110136005)(66476007)(64756008)(66556008)(186003)(26005)(33656002)(55016002)(9686003)(478600001)(5660300002)(86362001)(83380400001)(2906002)(54906003)(7696005)(8936002)(8676002)(122000001)(316002)(38070700005)(4744005)(38100700002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EIyww65NYwTAGU/f2jgFjyii0aBZWooakXRT5xCQhetgHyraHRMnnlvC6GIu?=
 =?us-ascii?Q?b+RRNFxMM7de9cgrNw8S4xxt52LyInbU6bhUP1HyfMceKXh9jFHvA3z0JZKR?=
 =?us-ascii?Q?ur0kR1LX9mz7LdI8PNtya5cvzTu7JUrUlxmt8YBmEDZXVMRCoHkwaCigxyZV?=
 =?us-ascii?Q?LttgvOHMEQfwhaQKQXHc9gMsa3jtSjFaFKWa0KWD+WX1Vrto+Ff0emyqxdIO?=
 =?us-ascii?Q?6F/C1OzyeQKCmigXT38IKGZHyj5tWfAjDkL2rS7kmEyTED1xuWER+162bJF3?=
 =?us-ascii?Q?YdEttwJDNIB15tmPcd3KCbplWu6JSpdvlkXOuoznr1p0/tr6zTom3r1osUgw?=
 =?us-ascii?Q?UQwi+0ijSQ65SaENbGllx3S7WRVZu+TVSeZL7dDk2DQlhji2A05X3iwo2Grm?=
 =?us-ascii?Q?3Clolxa96GChR5gUkLNIT2zCQNyM/1P3uICP6mpcq/AVEPUv8SKby2dmYMr7?=
 =?us-ascii?Q?L7IMUOTJ20DJhCNPoetafUlwr4mjy0fbRepQzkgVrTC7DXJ4sbfQD1sHZFMW?=
 =?us-ascii?Q?GEYf8ss3nG7p31qjXgbi0+R7zGCK3IbcHiQqDantF/cBHDQDa0DK0OmP5Y9U?=
 =?us-ascii?Q?6CPkDNxVsshwqN71s265/UMGZdfJUjBZQeg81sbRZhQ+CdiSLETHqPbc8J0o?=
 =?us-ascii?Q?kwLmoXBNosTXmpvfQXCeYpK0OtsQq/+rjXC5a363GmEiXYoZ7x2sq5okQW38?=
 =?us-ascii?Q?7zNQauuUmmpGmwkbIWG7iJ9ISr3wAfhkOiyQGCsPrzKvQF2h3R/jATC67z7C?=
 =?us-ascii?Q?Turj3uUkZb4AtW+eoJM8KWVFTiFrcvSZ4gj6yut6aDHwpU2jUN5oK9qXUkKF?=
 =?us-ascii?Q?REE8/dC+W5JX7CuxdVdefAkdgxWE+RnfV4TAS7FW8nbuHyYP5uur3nZ/2hZi?=
 =?us-ascii?Q?GsSc23k/EOopNFJ29mt6qdTI2EquswcxGdqUBbyvUKC66PsRmj6OPrkfMEPu?=
 =?us-ascii?Q?BkShhGrP5QIppEVBb/E93lRVdWlCXjxjxZf+m2O40Q5Um9NcFLz7xAIempWq?=
 =?us-ascii?Q?NOyVeprUuzY6mnrG4zA+fn7SaLWoc38CqEFn7xB52LjYiUQ5CecJ5FU0yYI+?=
 =?us-ascii?Q?4iREjceWBe2bejK80eo5w04Y6Dcn07ADxfUWoXgUy0FdA1A+EpxzedEvU6K2?=
 =?us-ascii?Q?SK3eSJbzVPuyy1naeZHlTJRBcL5hawPitBjAi+8nQON2NMe+jkkmM0GpOEhn?=
 =?us-ascii?Q?AyRUjE27OUfi5EAujumIBtL+AsTPTbHDjcNpl7n/kbLvvbl7w1oNwfXpqgMy?=
 =?us-ascii?Q?1iK73YXcmLxItOKoi3//OwW9KeESC3Pz/Y5UU59sxFvQJ7naiDsB2bkA8vyy?=
 =?us-ascii?Q?6Mp/E4qCnGV6WsOdcRVC7zGhOxYZ5EM8HmCGQ/8z8nJBrw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8b1875-567e-446f-ae7b-08d96c80ba78
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 13:10:38.8466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5TbTAk9Qq4gZNd2Uool1e3oEqhASD/bFOGwlm1S79ivYwkys0hwlzqNuTxeZ93gwU5HeoDLnflP7nvd9jPiy8SZOD11qtF08OZfexLIEm/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7607
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[ +Cc Naohiro ]=0A=
=0A=
On 31/08/2021 14:11, Anand Jain wrote:=0A=
> But let's see what part in btrfs_load_block_group_zone_info() is taking=
=0A=
> most of the time. Could you please help get this output?=0A=
=0A=
I'd suspect it's the btrfs_get_dev_zone() call that we need to do for =0A=
each block group in order to determine the current write pointer to=0A=
set block_group->alloc_offset.=0A=
=0A=
We could speed up the mount process by caching the device's REPORT ZONES=0A=
response, as we're doing a REPORT ZONES once to get all zones and then =0A=
again per block group load. On a 14TB SMR drive this results in =0A=
(14  * 1024 * 1024) / 256 + 1 =3D 57345 REPORT ZONES calls. OTOH =0A=
struct blk_zone is 64 bytes per zone resulting in 64 * 57344 =3D 3584kB=0A=
data to be cached.=0A=
=0A=
So the solution should probably somewhere in between, aka caching X =0A=
REPORT ZONES responses before we need to do a new one.=0A=
=0A=
Byte,=0A=
	Johannes=0A=
