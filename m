Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD39D25FD8F
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Sep 2020 17:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgIGPv4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 11:51:56 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22987 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730185AbgIGPvd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Sep 2020 11:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599493893; x=1631029893;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=MVdp4udU+4iRmT5vomjcYbcs1wmflliWtgU7moD/kjzodv+iRHNYbnlt
   Rbft3UOItC57v6Vi6WDQ+KN8rdfIzjL/KUOXqNV8YjeNnvMpFJI36/w0D
   a8tZOP/l4aBOAUaJDypcKjl3KBSO8IvWG4ccX/DQZA9sGJAHEJ5xTqI2p
   xiFVxA8Lteam8+cGjEakSShz4z+EQkOInTGvqtzINPQucyo+l61kmx7RK
   QwyjCNMRdoIT4SM03/mEpimyt4LxFu9l05GqH/HSOQbqEBhcTXx6Y1wwu
   M52kyl3CLhmbUSNoaqPvvr9av2k9iZa5bNL7zpFM56B3cc2soAlN4ahKV
   g==;
IronPort-SDR: 2WAbvpvo16ML5xU4+Hce6Vtdg6pEPzQX+qMTl9Zthqw1ygy/BfOWSCmKW/h6u1Ba4f3pwwG3mS
 jKmz/4T6/tuoN0ndvEpT8aH2IdASbjZUBgVucS7Z0Ue1ztJNDJ1cMkxgKqgsm7rZ0ckyR1agnv
 iyXQa7ujcjZiev7ewEwDRqPsgck/RK9j/uTs3selleq9RcQXkM3Zk5lUmspCcKIETyPAn2sanE
 7v4CGZD5R3jcUyBRZlLB05GdO9o6y1NIvUNGdPzwMIbIaW+o6+vxSrHFGhMyHYzOk6tSp5HsuL
 TxI=
X-IronPort-AV: E=Sophos;i="5.76,402,1592841600"; 
   d="scan'208";a="147977459"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 23:51:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwtQEvSk1/1N+gmkhu3U1DtQJ/Cz1RFWILwsJDPqV88m5qAwsYJ+SO4OWt8eJsCw0HwbbVfPqX3LQ4YeEDeASuWbvZwR5NWNtv7tJaGZ7EKdQJykKw3Qz6rj8QsnnXwK4n4jxfH3381+X3rgyoimGw3afoO+cWK2yxTJw8MYuGFXj8M16GCOo+uhRkBVea3m0ZUfv6Rs4eZBesaG5mbxA6zJJX6qwU84qz2uo0aHM0FfOKUYVRy+aT6z1sKmCLXyRPTt3lEMdaeIWMlmq4BrggWGPzN3ZcV3cd/vSje1jkcZAtakJMxDBV9zYaTNhmkzbvb5U3Rmd9CQKATOoGbZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=aRLLHWkEwQ7ScH4N5GH6PF2lVJmgEnac6R/CQG0YQSHVOQWHznfZqipYGM9mtTSNEF85o2VSEYcCpU5Ux54hM90xiydigXK8XGSSRmrK88vzv3pj/aCFJ2W7t5IhOeJ23tmWs+AbzcdkKzXQT4Q+OD4X3/UWnRCrdfvicZtxQKC7WOWsLNsDcJiaxTPl1O2FLki3G/e/Moff4VH3etvzmsWNGz/9C6aotV0uyXhGEuqg2bA4z2ulnbuVjZhg1RmuAbGuYulIVYAwcaWFRx1FdlA1g7AH10Cj4XaD+d3h8ZJQOylbhtC9Dme4LXdm0ixRAdKdx7BZnBYcWqkoDIVWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RNU3furlmj+ER+U4A2Eyv/0IUpoq6hPY5J3P+law3iVjArjrCpec2O2BlZvXMQTIROQazZT/mophvxAS5lPgMT8vGyVF+qvaa0yCGNGXYdx5qyeGxmnYSC6pc/gn69zVbF7BLIsxo95+0Dde9sJIySGhsfXqfM2LduPWBJENHIc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4782.namprd04.prod.outlook.com
 (2603:10b6:805:af::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Mon, 7 Sep
 2020 15:51:29 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 15:51:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: Re: [PATCH 04/16] btrfs: add btrfs_sysfs_remove_device helper
Thread-Topic: [PATCH 04/16] btrfs: add btrfs_sysfs_remove_device helper
Thread-Index: AQHWguG+UKx2yquc+UGTjEfLuUtcbg==
Date:   Mon, 7 Sep 2020 15:51:29 +0000
Message-ID: <SN4PR0401MB35981F05AABAB43FE6901B099B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
 <a273cace2fd1a00364d4bce7780278c561cd5fc0.1599234146.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2257d667-5bbc-429e-1262-08d85345e2d5
x-ms-traffictypediagnostic: SN6PR04MB4782:
x-microsoft-antispam-prvs: <SN6PR04MB4782D3434600BF5D337B636E9B280@SN6PR04MB4782.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N1m/v4f/uRTPdT9Y6W28yyKV195DmuPcTPq3TERgNa9M4it5eIaytXpm7pNg0ywHr7Uon+9gFeAojL+ZK/sgO7MW69qPks/JPHSuGVU07z80ehEPJ/RyfZvpZV+09zOjiGTR9s7cG+eJE6fQJEfpKaahhNcmBwRs48iZMlsjyauJRyyN3necbr8UMo3OyyxVUqbm/QB4pXnl7xuhcWYNrjFfPL+ZIR5MSCkgV/rft+0/N2fNbMm5KNO8gb8N//qO/jX8iU/Hkxlu4PKMmOO3K1SghYicXHl62wADlcBxUk+11dqELcFEUixFVyBrzfH27eX4gyCyXXnrS686GG+jOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(8676002)(2906002)(110136005)(86362001)(54906003)(316002)(478600001)(26005)(19618925003)(6506007)(558084003)(186003)(8936002)(7696005)(4270600006)(33656002)(52536014)(5660300002)(64756008)(91956017)(66556008)(66946007)(4326008)(9686003)(76116006)(71200400001)(66446008)(55016002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8bV/Aamai9kT8DFy9D/FIMeTx2rtCtivNl31ebeZXoUz8rM28UJfsgQFY99t3FONDEYArgno5IRI5VeU3kB87K6kHA64ehCj8U9wC454nw7VVcKnqwmAkPfx/ZEnadobKbocvI1VZEaDQoiswUCiwgENpaDeV4rQEUuJntw+xDBCHoaoO/8/PETdD4zV/nYE53kwDj5i1jgQ69PjTEGc8jzPXpL0NYLzRW1xQUpc710p8tydYuNmth6rbHhDR222admmkkD8eqIeMZ2J6aNandfVDFcuDYXl5IjjzkxpHl1TTSxU76FcKTaFIQHej9Ua+i+dXLeg25E7sofzP9d74Svo/2TbkEieeA9a4o0AvjyC1cvO/Lgg/xdyr0AuMzYMOFZGTgr9o5T7zKUqG0lzU6vpBszjoBsMZCg31Kz+KHY+KDudTFp7vx8nEm86x1YhmbKN7A/1mQ81JyZ6DTnODfFY1LmExZ+HuEvQ1juRkkY9qYGBcoyxSX/KH2Puw7eaArc1+gPNAgVkl6D2jkTCm6oavz2AR+Fa+taF5hw4KK4ErhXszML1SU6+1RybOWSjWcMNbtEVFdoYcthOU6eR1NiyxCwbBRGJjvk/rMfqDYFipBzTUMQjPgHOh/o21QUapjyfJ5m0AUN7Kv+TUvRjEg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2257d667-5bbc-429e-1262-08d85345e2d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 15:51:29.4499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZa62kIYudwAgtxoDKHSL9go88eZjMZZSXvUpXi06rKS//z6g1Mfq443sveSMKSA1u2pYDGVED15V4KW+5d7da+oh3q/fQoRBf+Pa1hMj+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4782
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
