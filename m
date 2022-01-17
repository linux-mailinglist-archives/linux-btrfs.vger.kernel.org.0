Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C154E490478
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 09:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbiAQI5U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 03:57:20 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45898 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiAQI5T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 03:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642409839; x=1673945839;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=rxczLfbzJCfr0pIwqkVNOwhMlygDiy9bXSRJ9yLlsIHLe6HkT2CCYloW
   7E57wVRDIr4L+fdl7ApGRoo5DNWtfZvYiAryUaOseTttZKDaCZWlc3aEE
   ZyLyKXLYc/uHNkTrmYOO1MQUnBnCzpqEp62ZgfdHM8gho9PNRFNmmWv2v
   bGlvYTM3xnM4UNHj5trQTH9YVU2gwDqUkkU4mPqXHBYfrZtiI6IG0Z4T6
   2F17yYTco5R5tJeYN8b2T4KEJsAGG9vcXZ2eIyBviIMQ0e9V3+mkdlWXG
   /uFdxYPQyMZELZyhzT7RV/RFhzGXYvjZMnVb3yzBzlaNXKqLR24CHbq6I
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,295,1635177600"; 
   d="scan'208";a="302503184"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2022 16:57:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbwMM3MK0Xmqsd5kZBcTfFdak/UWzr8XmJhPFlDQIa3VIpNnkzSxLb/8NPtGyE6jZuUCHG+dJ42wEiTV74Vs+9inTlMzKScQKaazzrTCgP1IACKzEdcFuhlLCQLb5X1qcI/wEJviz30fLsvLh1XLrA9R3vWcimsXcqL30BYE9GforeNm5QNsEsDf5sTKcvy2zpOsZrGDYyzvscJzM7SYMh4dXA+3stoyp5JxmEblzz/aUKg4UdSJziKeYNSbb/EXwSBUjuhefm2oCilqhVPL10gfpi963K0wJADrQIshlUejo2DSADKNCoBW3jQ938DX2heHPJTKbulmGRBwtN/SGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=dfJNEf/NTc+Td9i01nnvl7DPIpRaxpNAx+Md5h8+M7sKFNybaurOnGB7Lm7+M6R1PE27h019u1aXZ1m9LhZCTKXDpXN2+71eC7M9usWa0PBtAk/Nr5AO/ctIOboDQ/DkKE4bsOvs2uMHT7DkamXg6aAu+QqavxYBK3T8folFzeSCa3pcaVWmFY8DOYhXpd4bMj0h2EVbLpmu1w356+NqRUUsp/Xp2OFhKgSMkPNvuKJXZvtREJS1M+daQ5xq+hq4e12cfpSeI2pi4V/7U5hrUof30vLwohdit+I04fRJChlxjTw2F8tVKNusaVONQN5X346SDkwqavOflYnuw7qqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=lbSUfcRtjWGmAi2ytxT9DKevsytP+IMhij0tzrprRqTz3dJ50ejYEUdA5pLrC1eHJ+JuCfGemCLF3UFtlfKwX+3IkcLQhsUhcLA864HiHAf78/TD3axFdpiu5kEZhKVoskdShamsf7scbafMC+5rc0vvaAofdB4dLwWQdSR31BU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6703.namprd04.prod.outlook.com (2603:10b6:208:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 08:57:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%4]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 08:57:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: mark relocation as writing
Thread-Topic: [PATCH] btrfs: zoned: mark relocation as writing
Thread-Index: AQHYC3FUBtSrnJilLUGeirFvXsqm0Q==
Date:   Mon, 17 Jan 2022 08:57:17 +0000
Message-ID: <PH0PR04MB7416D35ADB4DB38FBFDDC81C9B579@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <e935669f435882ba179812a955bcbb89d964db26.1642401849.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f40aaea6-ccbe-40bb-d526-08d9d9975d23
x-ms-traffictypediagnostic: MN2PR04MB6703:EE_
x-microsoft-antispam-prvs: <MN2PR04MB6703373C301B3A172A6A33059B579@MN2PR04MB6703.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qa5QAoLQpsMF9066oOjkD9frIClPjLTpOq6rmMav1KdP8qiT1rZ4FzXQS5GbBOAM05cGXAnwltAPp8bx4QUMX+r2PaEEhhii3x6pbV/NlvdW34VsAPPXU+GWTVTKTgxcbO/gOTAUqwaQz3LfxLkaodbOFSgp08vLR838B8W2JUMingMly2EIAhXtpazyPFjhesEj3rIvDoxEr2rGvjWY/czwDiFSKq9Ls8qtVrSKCkqohfBY29TMLrR5Oxakm6FeeA7KLO/CjTb2C0qPXhh+VNcF+3imKyoftkIYP1TlNHnf0GtaPHQ4KfIBaaRHqDArQC3iT54qW+Yrp5J790H8r3eaIyy4dVQhnXjskiteP5eiSTQ0gaD6edVrG+Ua+2yUTPHZlAmmj5gUkZd7m39sE0fPL7tqu5lOxmYiPYjd1DlQC7p8h6jWdV1GPy+jmJUgBMeqkTrscd4OA75pio1nSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(52536014)(66556008)(66476007)(38100700002)(122000001)(621065003)(73894004)(66446008)(6506007)(64756008)(86362001)(55016003)(4270600006)(4326008)(316002)(186003)(33656002)(76116006)(91956017)(9686003)(110136005)(71200400001)(38070700005)(2906002)(508600001)(8936002)(8676002)(7696005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?09rMO/KiuhVBgjqDHvjFcimL7uk6aBr0QKBBHqvkLLZvaRRtct3A9hwTP97L?=
 =?us-ascii?Q?5vSEppDW+GSy3hd8/XvOQo1oXhE7Z+/0xlkrfhPBQLlQc2V2ZDvs/JDEDM1M?=
 =?us-ascii?Q?Vm0+VXoNbNOdIoYf1XtJrDCalb0aXFegJAgmib4vKpX5e3XWI7xa+Wyb/TGe?=
 =?us-ascii?Q?+HEZqfDlmr6XFSra4FPJB/5lCl5ONkbw65+zKbMkOJ4etPgydn7dULQI9AN2?=
 =?us-ascii?Q?dv38/MetH9FPEkqrtTpjIgUM9KhCKoqpxYJrBFxXfOT2w3sDhANY9oYnTiFG?=
 =?us-ascii?Q?eYAafocpN3KUWjs3cPPQ7+vx/DjZEXUO1zdhJoipKeZ+8xlAOjonHUSDTgFE?=
 =?us-ascii?Q?GI1/ZPeMr387j8XsuMQ5+kWSlewzA+3WJi8t4kw2ke5ddj+l4biV8R//JH2k?=
 =?us-ascii?Q?+wC/SKIQircMlR13bskL7k3DtZmW6JeEd1aDtGRfI/UOuJa/UMFXkXD4WDkW?=
 =?us-ascii?Q?fNcqbQy7NVDlasnzK+Oa/dYQOOChMdHIiUEHd1F3/zthMMorSEnSqKE0FRkl?=
 =?us-ascii?Q?q33wexbM2E01ACmAH8Zn2OCb5bLIEq7nBWZNRWjoIKonCvPegisSe5gd7zHu?=
 =?us-ascii?Q?w0N0mzzyUjENcMIondtqloihnSQLVCUYCA2UTF5apa1RFrm6ecVSP7Sn+D1c?=
 =?us-ascii?Q?xqu7YkmIILNvUv2AZJChadXZKiGFC1X86ZRL5gxJL2Dy5a55+goL82SZ9Y2G?=
 =?us-ascii?Q?pQQPpI3q/s7+zPJitgejo+VSRELn1cDXwzWMBy3eYH8aYsHPlEHQEu/vsNSH?=
 =?us-ascii?Q?WQX3sJPF2ePqosOXBkKLh6MNtmeZ7ZvQpH3jCC7r0UUlrg+1945p+iVgnzpS?=
 =?us-ascii?Q?lm3TLCkMR/eAJvyw1F9p8xpKV4nyph5FICixHalMnOSUExjikw6TZcBQr66X?=
 =?us-ascii?Q?YgmXD4RaXWCW8HIzre+4bl59RxAn6pwTOedBGjjcuubIRJeOSSQH6PBYsC96?=
 =?us-ascii?Q?o8G3tztxSMjfMBqXkhCagOF7CMA6R3toLKmoIjzZ3DKCIuis7AhGVGNGXnHv?=
 =?us-ascii?Q?VvIYgNrSulaG0p5/65NvPt0quPYp73ajlcy8VyJDrfRZK5yVfTrRBzulY3Z4?=
 =?us-ascii?Q?QCwSNgYnkF06RqeGKUSHJdu3lIWqa7DDxFbHngkK8+aD+ITIssHhFOpydlhw?=
 =?us-ascii?Q?ACSQO5hPJM1j1dtDLSS3y8nb4h7H951HeHLB8+zvW6XvW+n5jIuC4LWPwGnV?=
 =?us-ascii?Q?xGt31OqoWVIqCZpz66ikqk875+tyTHmWjMyRbeX7HUorSzXMINIHgt4IsrPT?=
 =?us-ascii?Q?QyFukczbHo2o/xm/Hlb3Sr3Uj402UowOBhDBMEoJxxDOCWXoqBSmjFiAaw/3?=
 =?us-ascii?Q?erl/nEwgpM1p91lq3eunjTh3ZTBwXRCBASESVh/EU6q7wEYF/2KWJuRTYSAy?=
 =?us-ascii?Q?/aJBqls07vcRX0t6jcoWpqY2joQu9V7cypLaiB2q1hPI9F9xXScAqzTDbabc?=
 =?us-ascii?Q?Sy/NUqXf6I6YGc5FEzr4ZMTOMow3d2yCebcN36dn9tzGBTcqH5BD/DVDjWZ2?=
 =?us-ascii?Q?MBP13NWFTNP1Rxo+AL8Q1HPa4xEZymTBtL/HRu1xbbKaOlyBLdi9djW5fWSD?=
 =?us-ascii?Q?sULIGr/gafQBtEURJiKHQopQYcA4Wn7mijC4z5Jd376UxejQT57PluWl2+j2?=
 =?us-ascii?Q?XXY6HGjDRigGGj+3rGXoc5/MuMgEs6HhzdnSU31S2KUfxDevMA+Cot3mLudB?=
 =?us-ascii?Q?Gnss0HWF2QX+JbdClR8Ur6HA5i8W0HE2W7Yx5k/1abDM2CuavbHEQkk2+0Lw?=
 =?us-ascii?Q?eQp5NbejdIWjnx1devkDO9c1AGeJSJY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40aaea6-ccbe-40bb-d526-08d9d9975d23
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 08:57:17.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gtCwigHdaXMMtxztvz2e/+uJDWwdfXuG6df7Cdep4/JHBbMaiBfqG2918YK7du9veAWm9zM8ZmLSu6ukYhvDlzgCVKgOv7vRsWboIEScTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6703
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


