Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DC038FE01
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 11:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhEYJl4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 05:41:56 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:18474 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbhEYJlx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 05:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621935623; x=1653471623;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nAnDUKoyNfHjHZl6HjemPXuCjCEJOGYTg/LpmOALSK8=;
  b=jztOFnk+NpGPEJfAOh4ULCG9lvOs5xBaA22WXpV44dVIasEZpUwUkpXa
   Yewf5aoD/g7GE/5mKTBlW4tYKZ6oWINCor84bHKL54mSp9kMyc2JV4boj
   6+E5k6ocuVCBJmV6AOlci+GJKhXpFEAp05CSpOKy1Xq9o5nbEJnbjAniC
   nle9IJ6k0/Aipiihe9yfYbq2mk3lviRh0pt6PRwKlOnxLjsO3eTgkeQwy
   0C/YZF6qTKrJL1KsLAVYtASae6dkxuK7M7Y1YjBLICnPw5zmIlhtTx+dJ
   Ggz2ru8vIo3nazRQUSGDwfcch/mG3B4phvdpX8eXltyUzvJ7Cpu+cMHg+
   A==;
IronPort-SDR: SSHAdxI8HU0IzaGUGy26Sr6mHArc0S2yiw5QZEnIJ8Z58iMgYIRD50+G4m2pGgrYYBHCAUr8wk
 +uVeBwX4QR/qdkENGeQwxHeZ0yqX+zbP8I8G5LwCZTfWcRJ3kgVvoodpRS5KmXntrHO8q8sUr+
 9a3r5C/8dRcKDk2fECURPoVEH/YcakyGW8fNRDchS6dFJF3dfIGa/hTwoPC5pFYZ7zAvS2RSPU
 Q/fUvy5a24fQ4Xdy2UV6LdrTdhB+16azlt3C6hv1RBL0rXc2gIkuyIBKiC6Ni6cwUDkll+AZp4
 B5c=
X-IronPort-AV: E=Sophos;i="5.82,328,1613404800"; 
   d="scan'208";a="169343571"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 17:40:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlgViq3byhE88PqcaYUxww6AuPRJvlf/NLi7ZMYhUlxCYLcufs4MggroiWaEH3MO1coYukE+8+W8GEj1QHCOZyV0HqUYsYR57gn6YwyIGv42Wt3aoAVne7w74N5y1VnPL7npdV+jCAwyZBnvlD1Nr02uXsPz+C7MaXU1DEHSs07DHVy/UaiRuooEWhV+16zwkDQtn+cJq74sij6ul5oYf9dSGhESvehEoYBKjhChCVSx81GVheZb6pSaie0UDri38vLsm0YtAyal+pFYxvVB5tF4XIljWCKi0ma5saP93LlnVm1FKXXfRL+NluZVOqt34BRWhqej0FaKNwOPf9XLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXWrnrq+g/Dn075L4O5q3Gn3RiFPTyioFNBgaBF5vr8=;
 b=WU12q5nh3OM8KljhRGkS2s0/C2D1ufGZ59PuJai6lIm3pTyIK1z6sD7fZV9xLo0tf1xquwhhbixhe+8N1qtNDRXWer8Vwpvnrp3LQ5/g/QZHfIss9LhT2VbsTqaQNZcGlCsD3+gMr0xfPk4PInk8UaeBAFymFFe9gXWKDwFbspns/mpSk3O+LWb8ijiMdvKm8YqGnN/B0ZYJ5XSu4nU+y/Gko0YcPJjVHhVZvgtvyMKrzZ+yBntU8n+vZBnPUTHlJtjcTmMpUO47MI8lXwGSbvqQ2EplK9dK6HXLIjGvpJgbrMfMZdUQnXAyrNK3OIh2QXyYPLA76EMwb4EUTEKCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXWrnrq+g/Dn075L4O5q3Gn3RiFPTyioFNBgaBF5vr8=;
 b=CvbwolCxS7RkdQhves8s/bTuth3kUd/CpHl++mZPSgIS7YVo5EVeuQa3gzPQT2aI24FDfMi69w0knk2JqGnlwfcpoEiXh7Q/e1XE5M0qf1a4wUSGtldx3z6sbnk5717aj3NwHRy2MlqhGjG2QVwklF68yLippnciAF3AXV68sh4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7477.namprd04.prod.outlook.com (2603:10b6:510:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 09:40:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 09:40:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: limit ordered extent to zoned append size
Thread-Topic: [PATCH] btrfs: zoned: limit ordered extent to zoned append size
Thread-Index: AQHXTiFEXNaFexnNjU2Pxag8tm94KA==
Date:   Tue, 25 May 2021 09:40:22 +0000
Message-ID: <PH0PR04MB7416299E1493D6A243375B9F9B259@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <65f1b716324a06c5cad99f2737a8669899d4569f.1621588229.git.johannes.thumshirn@wdc.com>
 <20210521163705.GO7604@twin.jikos.cz>
 <DM6PR04MB7081AF42EBA082FD09A07BD5E7279@DM6PR04MB7081.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f2a68d0-f4bb-4385-65bb-08d91f611de7
x-ms-traffictypediagnostic: PH0PR04MB7477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7477983AF5D42552A3643ECB9B259@PH0PR04MB7477.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tonE89c2olWO3YjcZQ5DEsCTcR2XlKvDYom2oHovEs2GxQuOmo/pD1MqL4Vabwi755K+3djmOCA4eRAcDf+R+0KMoeu8Rz+8hwGNrnmI8+jOTGUqjmcUefK77doq4uQngre946WOaMveVLVabMkSZT1d6w/rEV6sPFSco3zabTjXVzb+QhBtIPkYnPwKfNLw4pn8IcZOFM4PfOlYIAE0VvLPITyTt4AWAa3FhBWucECidbgYz/wL/OJSoWy5EZZ/svDOmO9LOkgdxcr+bG6dQOd33gzF25RFVbA7n3SXgLBRoUjPTtM0M6nL6LHZs4T2G75dvo2XDI4sqW/33CCB4Mzr64FKOuz2K9l8QYVA7XG409hq98GxtsIv4ihrdWOTxAeLvIOGkj8Y5bPnDhYukZHWuYPMc8QxxpSWQOrpB2BfAm6Tya8oVg9LBIx2ClFITY8fopAXPy3GiPN5K9AfFoTrJ9b72+9JcvyyQ5yRIIZfguABkpuGB4pI+8h6QIpLVyV686LpZ2rQqtOvLXdKSLaemxCnLO1EuhhcDDPc2x56/X2oJTdprCd2HCQHL40/Dp4QtiMe6xrhhdhpHI/P+VPts8m/fqho9+d+B5l1Jo4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(186003)(26005)(8936002)(110136005)(66446008)(83380400001)(66476007)(6506007)(33656002)(4326008)(122000001)(7696005)(53546011)(71200400001)(64756008)(38100700002)(91956017)(76116006)(8676002)(9686003)(55016002)(316002)(5660300002)(52536014)(2906002)(86362001)(66946007)(54906003)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3RPp6QeiHJeoaYCjbN89tetepcoyjz7xIxa6mGuWAzaT8hffyKyaayEAzGVQ?=
 =?us-ascii?Q?HiqJdNPoEEet+tfVdkBkeNPUDSwbSntQ/OIqKz+4KFHOmppyJRgFgX43YZKA?=
 =?us-ascii?Q?qRP/6wq3JBCeDXnVmjLglWM+4ZumHF6T14BqVZEtSN/4+oZ3qjbEtcaguKVW?=
 =?us-ascii?Q?SOcYrF2a3/WuutOFenQ3dXlJHam8mx8mtnUppDMHzE8P2+6XCVawMJLc5xXM?=
 =?us-ascii?Q?WyBG9YYlelAuVTlSnlPFUo2AcfPYr56jZDbQuwXCjrriqMUmE1Ce2B1U7w7b?=
 =?us-ascii?Q?oBl9PvUpSWOnQHAc47xmUUsn7G6tXXMGMWRyqbx7+8b/TsdVX52yQqEb0oXN?=
 =?us-ascii?Q?F9jyZgAzfegxKRheEd8HZO9l0iEJH1jxpJ2D04xK+bFzTr5pUunKJp1Gvr1I?=
 =?us-ascii?Q?hqk51sjKB9C2pw3k7UwsFZYmLu3V5kxNIkTMn0bWYDu7mPk3OGiAS8ckUZZ8?=
 =?us-ascii?Q?JWYXJXHnJjUgmCl86cCq445qjep5MQxB1bAU6DBSm1mKndvMBF4fqD3vP2j7?=
 =?us-ascii?Q?Q10v0Y8W5tZP3d7OELigLNipL81v5Z39cW6AK0jZm6CFUElL8SPNMLh30f19?=
 =?us-ascii?Q?d4vR6cAB6wlWNlDaVKTj6K+l0LOrNgP6hauMla+d0KOxXHCzvtdH2zMByZws?=
 =?us-ascii?Q?1shjhdXgAkjneQ2fLPLsT1sBlev/3ifa2mz6tY5ENJfbKU921QG9yX9BeL6k?=
 =?us-ascii?Q?Y3WZC6YfNm+klOkicLrO2Lvg8qk8Ee17oz1rO9AUGegcXTftOUSoOO0rJF2Q?=
 =?us-ascii?Q?/97t5Qb5UTOIw1Ii9vqh95539aKlULhpKWuR9Rj6epOdWJlucubBuAUCW5Zl?=
 =?us-ascii?Q?8Ix6/NYfdamNmrAKEAjwQxUVMD8lieWBgJ7aC1reKXKVaeZXKCrRQoHOCYrf?=
 =?us-ascii?Q?Q8RVtD69d+vWPcILOk5IV0kRUUS6wQFH2P5xNUkkxCSYpbvEo3wETm3sjZMb?=
 =?us-ascii?Q?Fyyw0uHLiOOY49kstM0ldPL8jJbVuAUFELUTsL3BxgbMNlqETRzvhz2ZHm9/?=
 =?us-ascii?Q?dCh1iwfqpz+8nq73oMrUbDF0ZFG54rqDaAG6rvxSHyDrlUg4ecU4Z+l/269V?=
 =?us-ascii?Q?aQ4zbykwCQqKXhBuNXLqifwkyz9ZochxBQwbJM/HzMIXOFLEFmAZ81UDiW0X?=
 =?us-ascii?Q?aJ5FoUmdR9kTEtKyjf/tHRKuInEDreKFmaCorXj5ATOCebaYs2HQmg3uUaeR?=
 =?us-ascii?Q?7HALdeM2QJzw9EKCdemHeshVVAmkm+KLpLbJusjLZpq7v804X82UiCvoeZus?=
 =?us-ascii?Q?QYo4LzTjl8a2Z1X4dVXFsmbzo30uDONsv3aUMpqz+CcTek+UTBCN6eRSdl2f?=
 =?us-ascii?Q?UT4Ru7Okf9iCrCxj45L30AojwdvXz6jovTE/sWiQWK4NeQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2a68d0-f4bb-4385-65bb-08d91f611de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 09:40:22.1995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjgWJa0XKJO3dnvCEWxmNlROt3xId6mtOwi4K6R82EIdaTYP8KgdljtDZqc9uXGqXZGp9vha8/6pKKfA9EeVIB7Uq9SdnBB/WyrNoUsSmP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7477
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/05/2021 01:05, Damien Le Moal wrote: =0A=
>>> +	if (fs_info && fs_info->max_zone_append_size)=0A=
>>> +		max_bytes =3D ALIGN_DOWN(fs_info->max_zone_append_size,=0A=
>>> +				       PAGE_SIZE);=0A=
>>=0A=
>> Why is the alignment needed? Are the max zone append values expected to=
=0A=
>> be so random? Also it's using memory-related value for something that's=
=0A=
>> more hw related, or at least extent size (which ends up on disk).=0A=
=0A=
I did the ALIGN_DOWN() call because we want to have complete pages added.=
=0A=
=0A=
> It is similar to max_hw_sectors: the hardware decides what the value is. =
So we=0A=
> cannot assume anything about what max_zone_append_size is.=0A=
> =0A=
> I think that Johannes patch here limits the extent size to the HW value t=
o avoid=0A=
> having to split the extent later one. That is efficient but indeed is a b=
it of a=0A=
> layering violation here.=0A=
=0A=
Damien just brought up a good idea: what about a function to lookup the max=
 extent=0A=
size depending on the block group. For regular btrfs it'll for now just ret=
urn =0A=
BTRFS_MAX_EXTENT_SIZE, for zoned btrfs it'll return =0A=
ALIGN_DOWN(fs_info->max_zone_append_size, PAGE_SIZE) and it also gives us s=
ome =0A=
headroom for future improvements in this area.=0A=
=0A=
