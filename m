Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8359936F84F
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 12:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhD3KL0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 06:11:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16103 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhD3KL0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 06:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619777438; x=1651313438;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tBb2yKj1qhqVEH0Eo+f94cpaZZCIRJCrXzW89bFPUeM=;
  b=PqP0GulKCp3MjmZrpGZIH08WpbK379pxLlKS0Ekcd4iUZ2TI0vqHlmhI
   LzyCezO8IpeOTJLh8KS42SjHeDQdnRWpKsSsifisExCoAR5B9FEhid4Ji
   Ie7+RC9B3i3HJfsHEZ8FboSemAw9bT6ezVrJRrhBdEMaIn0NaJXD/YaSB
   dl4LUt5A5BgB8x2a845RQNPfu6S6MOSxwfsFJo5ihuhnhUsd4J2VpXco0
   L50pWqh6KMaCv/B6r5U8PKrurvWJSOrJ8hMbxLMtPtCKwEVGqG2XSrg6Z
   P7jsLmikKFkwye7GsjSbF1WfRlV/ZxZONxHD4M8e3KbhBVM0WZ6rAi/k/
   A==;
IronPort-SDR: 8eAsnVLx+WSDYhsiuX2775lcWo+1aihoslEDhPNlSo160Sne6id+v3xJ04hz/Mt0HpqfFH2VRN
 kk00iPqXhJc8fuKBwqanJ1HLQA9StV5ISTWgEPfarTfc/HAeoyMG1SIdL7HBTe2dFhacwChVwU
 um03TGumd8yF48nfVBMRwkqAIkwcfc3R22exz2ux3L7kSMDZkAwlZ6FxxvX/78+ig2dxsKl9hA
 zbgjjwL29j9wW47EaGFPH4XFe12fSK6k9WxBn1qlXKXTY8n8yzTKvlf/59hwKW7xEuUhImnAAp
 OK0=
X-IronPort-AV: E=Sophos;i="5.82,262,1613404800"; 
   d="scan'208";a="166116420"
Received: from mail-bn8nam08lp2047.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.47])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2021 18:10:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhQ0T+uabdM0HUkoK31l7Er/Tyfkz+1QQKIrmv0Gapmg0GUMLd6UZae3FjyzCFC+lzYqo4xG6OnKcezrzXak0AoeaAyjQevNphDJcXiG+1LNdYdP2EyjDct4xGJBiZ2xv6skgfEyqB/6lygowQQI/7K3be4KAfZn8TREXlIHKM9ObRPiPr2nzSi8E97YOf02/BAnX7pnJq6a8XxlgBdiS17Zgob9Z/ZLGtbkquD6X7IwjcCgFxk0R4ZMPfD3nr3hHRbi+a5okpL4iUTgab0Avs4USgW8+PuTZj1bniPqeK5VjQevd2CehG0BD+S7JoLxb6xGXspNBqn/HRwt/62q+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoD1hEJ5c+HAvOUn9FUAUHfu9gbsteg/K2h/MIRDDJU=;
 b=NFITvN2qvHWf4BDsBfk9IONZxtobsZYBOR2YwX+NgKe+KpoV6UDROHR9aI3ALUgqH2ktKVc+0dHankbtXnbG+cIOn4Yq6/z2P2V7Ox9iWWdXSNVffrvprQw9/YPdFtl1E2+fnlCeEbBFbwGcWBPtrWE+CIO4/wCXKdcK8kS0OhAsYkB4QFwMyvsrE8YEdzx3aQgmyBJYCrDB1P0FJPAfXltaQPzu1e1SDKWpPyxW6mLROhnTuO05kEryXJn6RCbU2DRV8DyKC31tZjepiIsOulQz68/ZZSiTwRHrg/iyn8bqrEWp4ufoKxcheBzUCR1ZtSGKdBLQQ4btrs8UWXy+8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoD1hEJ5c+HAvOUn9FUAUHfu9gbsteg/K2h/MIRDDJU=;
 b=RuQlUJhm4fDmd4o4tit5/yTc8gpzyF/cyCoCuC010nlnCPwCIJ96J5XVmxTlAq/ru8Bi3+cf8MiETUeB3l27Q8zeJHpH2EEn4v+pQNvhKWYGjXc/TUKaNp8gCm+GegNPKI2rmpdvpCqBp7jYrFyuSm0m06wxPB4Tm168jJ7/VHk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7622.namprd04.prod.outlook.com (2603:10b6:510:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 10:10:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 10:10:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     Eryu Guan <guan@eryu.me>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v3 2/2] btrfs: add test for zone auto reclaim
Thread-Topic: [PATCH v3 2/2] btrfs: add test for zone auto reclaim
Thread-Index: AQHXPPS19yApBNr0/EKVohgj1zDWsw==
Date:   Fri, 30 Apr 2021 10:10:33 +0000
Message-ID: <PH0PR04MB741649C28FAC75EF0DD9FC7E9B5E9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210429123927.11778-1-johannes.thumshirn@wdc.com>
 <20210429123927.11778-3-johannes.thumshirn@wdc.com>
 <CAL3q7H7RpTjP+0fgcfiJP=w3o36e5Hz_twLHdE6j6rzN=+YbFw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6164a56-ed26-4602-d426-08d90bc03106
x-ms-traffictypediagnostic: PH0PR04MB7622:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB762273A5F95E8DD9434B7D669B5E9@PH0PR04MB7622.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0KJikUeq0lJA+3E86j9JJnOZ8QZPQ9jcZH9YuyMFzlOfzLFmxw3+0h8dPqFv3MMq9of+ZpKl+qf2k0LZo2zbSAqnDgHjzhGqg83pagOEBRoZdm6psaAq1Pe4n5vhr9ehf6JEOTTpuw6mCO/gewvjL5PCLEbQ+3+Y4s1WAnNqREK+xoKqA+ctSmKKWNgwSDYzw3ouvxhYEAWy/vWDCqA9UnBhhAMpISu2yLSpXR72B9YdunJiPIcHzGO7dIEL1yhOEv57ZsbDSiEHZutFaysr3O281F6hiKhtPFcfp83699/naIvKVGMXcF50gmJEOxm6Yeg+a0Cdhy5VRD9WS7MpoRS9VQyiqQZkD7V9sE0A/aij/Lvr4n5qQ45wn1Fp7XjEy/o52QjWJiniAd5dmb54meYSM6Gqvb/T0N5NLhYxiky05Ng5XNog37oF4+TSPOU+6pKuD3DzSgkams3Ie8tCluNYV+zEhpmuYTlar6nh2KL7fln267ZqMOSbCptJ4k5op7ZTwNgOP0gjZmB60Ovn3+8oEqT97x/nJ9AfdL/mbg9dwjv6tKE6pXugA3TO+QgaOFMKzpUus8sZNQXGgqlqaE67fx/4+tR7snP8LpEZuTw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(7696005)(6506007)(122000001)(83380400001)(38100700002)(76116006)(26005)(86362001)(4326008)(9686003)(2906002)(55016002)(53546011)(54906003)(8936002)(33656002)(5660300002)(478600001)(8676002)(52536014)(66446008)(66556008)(66476007)(316002)(186003)(6916009)(71200400001)(91956017)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mZlKUNPBxteW+VFXWsDT/CRg9U/ShYMlzddzpwEuLU6sjihGFwEqKpseSsLs?=
 =?us-ascii?Q?pkYlGxFlVZLU1sGGyhLILtJgAma6qS5CuAP+vw13jZr9W3k/+UtIznYuNoOh?=
 =?us-ascii?Q?DNpVzBz4eo2YSo7bE/keVchDcS3PDHX2PjiABbQWU7Pm0NGmkpUu40+kXQ4C?=
 =?us-ascii?Q?4KZlssJVf2b5vzu2Fb6IZQC6QY09bQ9sMo7nDI2XbBV8YN+yVTcOwN0cSNyK?=
 =?us-ascii?Q?R9JM3oIqf0dFexzkm2/ZkkZLoSnOBajiSLt3h6bGbqh/NmtnaSLvW9Ny/6K/?=
 =?us-ascii?Q?cN6PHXD3cxjd6dwJBGanMbckKZHM25Vr2cAtI2w5BHVJd7pjNFhAH/AgWp9p?=
 =?us-ascii?Q?C/oP7CaEOSvpjcLe7Rq4KSYPYiGF+4QpsnfqYu97zKktVOQkeYIr6iLCDoHQ?=
 =?us-ascii?Q?Hn7Tz5kR7fuFgOj81Z7ZtGmExxcei/zPvT5LvHj2Bl9tSYvIDXr8df5uIJob?=
 =?us-ascii?Q?xLL8Q/QFlnLUtlhS3byO/9LenJ6POLpf3stsowsWqGjxE7r16ErKfty6oZsa?=
 =?us-ascii?Q?43XabXB3bmo5yD2qL9diWOpLGpVa2ji4+dr2YVJFuImZvipeHRdQ7HJ/r7ZJ?=
 =?us-ascii?Q?hlN5E41fVzUXtz8TulNgSTWV8uistzBsSFRdwYy8PFqJGcA0Z6uCk6KvuQAm?=
 =?us-ascii?Q?V82HkNzagfoodGZwwSznzT6Eb3kLbrRXndWv8Bm07YaPRfn3/YBQrFPXdO/a?=
 =?us-ascii?Q?ubIGxn9hwM7rEPrXQBw+RzhVzofKGwhtJqSNpSgGcLknx2dph0iDGCOIPCja?=
 =?us-ascii?Q?PQjFO0+TiuLrAVYywArjut/w1g58gWuju26r1cc3J6YK3HF/hKrQ7JjpvYaF?=
 =?us-ascii?Q?uGLRlOJcd0dX9RGUgptHxVbFRsli/DEZH1yl1Hh/eV8id2rxQcvH0Pb2+r9P?=
 =?us-ascii?Q?z5U7vbCIGDGNYbic0efvgTS5KOPAFqcvy8pJj5UjhReckAprCxKEesRr9bjh?=
 =?us-ascii?Q?3NQswcA2CYB1Vh0jW5eUvrE3QTNx+UcCu7A9do4dWi4O4wlqCnTtILEEoE74?=
 =?us-ascii?Q?D1BmVh6owCWPSXjYyKknymOYy0asrhOsknM9D6l5CFOgP4jpNvXDNpY+bRs4?=
 =?us-ascii?Q?9UkBZnmLHOPeXcervxil5VRmJ9RQAb36eR3qs7zIeFat/YrFAIIoQk6tyzlC?=
 =?us-ascii?Q?DQTN7WR3dZaqbhv9Ki54u/cAF5IUsiCoLcEsGktQ+/vVEXeEt8q7qioA1pxT?=
 =?us-ascii?Q?g+tgBEF76PFDdYyAdBX8Lr5NpYtc+8vCKS7pE7QQr9J+M7K8iRbTw0pEuVS7?=
 =?us-ascii?Q?hw6TZshHEyXjQ36m3pAsdRaVDh9+JctxnM+DOcII48r1AH1sRBCgGp5XCvnk?=
 =?us-ascii?Q?3NI8lolc/kWW20Q6XziwffC7+lFy8GOXvWc48Hyn32d7aQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6164a56-ed26-4602-d426-08d90bc03106
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 10:10:33.2349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 33SJp46+vTaWfAGla1Xge+TB5AXDVGKY4Bc9+36sn/pXJFthcQOhDAvZe53OX/rTUx4nTELrBSx/mBR4ZDjtQ24TUuBosRWCZ//VgYj1/Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7622
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/04/2021 12:05, Filipe Manana wrote:=0A=
> On Thu, Apr 29, 2021 at 1:40 PM Johannes Thumshirn=0A=
> <johannes.thumshirn@wdc.com> wrote:=0A=
>>=0A=
>> Add a test for commit 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim=
=0A=
>> zones").=0A=
>>=0A=
>> This test creates a two file on a newly created FS in a way that when we=
=0A=
>> delete the first one, an auto reclaim process will be triggered by the F=
S.=0A=
>>=0A=
>> After the reclaim process, it verifies that the data was moved to anothe=
r=0A=
>> zone and old zone was successfully reset.=0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> Looks good, however I don't have an environment for testing zoned=0A=
> mode, so this is just really eyeballing.=0A=
=0A=
This maybe is something I should document for the rest of us.=0A=
=0A=
=0A=
In essence it's:=0A=
=0A=
create_zoned_null_blk()=0A=
{=0A=
	dev=3D"/sys/kernel/config/nullb/$1"=0A=
	mkdir "$dev" || _fatal "cannot create nullb0 device"=0A=
=0A=
	size=3D12800 # MB=0A=
	echo 2 > "$dev"/submit_queues=0A=
	echo "${size}" > "${dev}"/size=0A=
	echo 1 > "${dev}"/zoned=0A=
	echo 4 > "${dev}"/zone_nr_conv=0A=
	echo 1 > "${dev}"/memory_backed=0A=
	echo 1 > "$dev"/power=0A=
}=0A=
=0A=
for d in nullb0 nullb1; do=0A=
	create_zoned_null_blk $d=0A=
done=0A=
=0A=
for creating two zoned null_blk devices with 4 conventional zones and =0A=
256MB zone size.=0A=
=0A=
> Thanks.=0A=
> =0A=
> Reviewed-by: Filipe Manana <fdmanana@suse.com>=0A=
Thanks=0A=
