Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D3851A4D5
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 18:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353045AbiEDQE1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 12:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353042AbiEDQEY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 12:04:24 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0893C15A0F
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651680048; x=1683216048;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i07MnTDZJjUs71Rc8zG7tW+66r8maCfFU2DX5Y3Vspg=;
  b=RPi1kMa6zmcEscioRuUA9ZUTZnCYIWtwzALaJuPYixMPJaWVreLVWcY1
   MG7xIO2VNtHPiMA64haWqCWPlGXru38z9H1/pWINdnwYshNbiWEcr0ScZ
   nIFgeApQG4AKuTugSjV7/JHvdtPPj7tYl7rQeewX8GuQNjTxcvALgBFO5
   IC1ja7j0tsDESdOvXZ8WKZphKxArzSoVydSiHemj2GgRZPwptkWBmcOdi
   8HlQ8uBrQDTc2IKgWt4EyHU2KDQDDTewZWT6MJ7Yz8KWalFL0bwNsaMm9
   ts1nahJvppinBImhf8wqyFohMP4Eq5adHZW7uQ96sxfXhUG8vG/X38toq
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,198,1647273600"; 
   d="scan'208";a="200395693"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2022 00:00:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4EJ7M57hc49mRTjPTQ25A3ZQ1zM/hqRfhRTCYAHn8mjSID6T5xIpNuuu/NBMPaKV+XfuEj8mordpmwvN3/FIQLHxZbf2EFNq+Q1604FqAJfALXNaFC5y78K20RnTTZ0Vr4Rz4g6EQYfbKGHQqaCrmGKQmAAEtqoZcdSebjO7sV2gQ+SMMtUePMFIFBnKb0vXp58Z1lwJ5W54SudVK/2uoz3cfZcMZcwYvMY2WUXP6tMPMwzex++a1zL9GMz0J3RASCkh0SqziH9iSzyYJW8J4UxzHQkgPfHvIIjTCA3ptMrCXTrLCF2/bd6hoOXHQPefEe4OUJsGH7QlOY73qXqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i07MnTDZJjUs71Rc8zG7tW+66r8maCfFU2DX5Y3Vspg=;
 b=F/eKhHHlJuPfILlkKqGAi5p7Cvr+jcFCtl53vOw0V/6xoMDVYY5zIc1wd66O//qPb6ew7EuNlRBbaP3a/I2Cp6PEUNhqSUK1lETCrZh7mw1r6BFr9pAzNsOwzxKliQ6tP4yGBNzOQZnI0MBpzvwF8nE8ztOSmpXQong3jx6e3Z94n4I37g1hUfGPzhBacJWhq3vAjZMh4YrJA6v//LjrUsoYasqJbp9Z7TnJf5i3SmV7+hJpfKHK/tpxGMilpcWWI0v95nv8CYGa8TBJj894dQ2xWSPaPmnUvDBnl/FqNsXinImy/zVXyXMSmC76rexsRhfx/xMHjs63XSOsQMnXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i07MnTDZJjUs71Rc8zG7tW+66r8maCfFU2DX5Y3Vspg=;
 b=pwqnbfQ2Xzi+K9p3nvMwTjM42j9El+dz9M+DP1f1Ff04xuh3Oomk9fCU8/IwQ86Tqm/p8N43hrnllmGGdP+9PExCEEcR1rOKkrLVBXcog+7tiM7VfpgQ4cBHtXYNKX4DxIYA2EiYqt+afIRFUT6tFIZxyLM+Ef6azNbpsfbg+Bo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6009.namprd04.prod.outlook.com (2603:10b6:5:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Wed, 4 May
 2022 16:00:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5206.027; Wed, 4 May 2022
 16:00:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] btrfs: zoned: consolidate zone finish function
Thread-Topic: [PATCH v2 2/5] btrfs: zoned: consolidate zone finish function
Thread-Index: AQHYX1DbzUTplIiiYUedhXRVPEp5hA==
Date:   Wed, 4 May 2022 16:00:44 +0000
Message-ID: <PH0PR04MB7416675C533DB6065F15467A9BC39@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1651624820.git.naohiro.aota@wdc.com>
 <3710880ddfd0ce03bc0c239dc8665a846f0049c6.1651624820.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cb857b0-7595-4027-1214-08da2de73efe
x-ms-traffictypediagnostic: DM6PR04MB6009:EE_
x-microsoft-antispam-prvs: <DM6PR04MB6009CD72F702C2AB9CBDE0619BC39@DM6PR04MB6009.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2vVsNXoBvf//0Sv35r/GRelmX8yRVIXlOejC0Qoi/i8ImVxG+jAbY65yK60yyfW0Dhq0X7r901NKBzXPCdNY5XvsHR6H2xrTHuFaBET1qk5vyDP+8ecQ+PvTOulQhYI2f88cIDGjnIeE8P7dFnkT/cOZ7TxclLRCHUAIiMXzDiaWu0bmm7qyMwggBvNNsCNmf4QBb7plbh7B/t4q9VUvlH0deHFVSqn+3a+L2LYNMxzyYTiZL5O9PNpNh1wQqh4+MapSOqSJWuVYoSjUhtcP6bQR0I/p4mDZX7GP/8QC0jVUotrD50XAE5rQl9wPg//qUhoSFva2elquM6dGFaxDljtxL32BOWKwN1J/t0mujemEIbQuzJWoKZAbp8wgNuEMgmsnT4D91rXLEeh2aDh6e7p1fkCFA21HsUu/l9GDA/K0kDsbreYW+S0FSNDU1Yhnzi2UlEav/zDFXQOok0g2hYSU3MkDRjWTQ0blRa2FeGT1vsHlY0Mv646+dHGbJgGQqjn/W4yOc+5nL8QiKaiXzRB+zpAUUPCwdctQQDQjhSaFNzLZJAxicmM6VpCKXUGiHh6D/QMXNSS+Kt0UtbcFrqAxjt2x6yvIitV924n5E4dP3Hlt91hQiBq77XOvzVCWi59cd4C3yDVLeJDP7WMrttmtIK3hLdx8nd/m8Ahr9VC9gAvuFYhmzev7cpkKrpKLRNkS21+IpJPTZ2WcmeEcnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(66446008)(82960400001)(5660300002)(8676002)(64756008)(76116006)(71200400001)(52536014)(8936002)(66946007)(316002)(86362001)(558084003)(66556008)(66476007)(9686003)(38100700002)(26005)(186003)(33656002)(38070700005)(2906002)(55016003)(122000001)(508600001)(7696005)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rIk/xM3WBF1DfvtZ0ptxPJaLS8hDUG6/O4aEJVAfO8ge4q99bK/8dxqmjj49?=
 =?us-ascii?Q?d9FJbOrzevI4V8n2HFyIwOXRGk2JyoPLDI11wfb6AkxNr0oPbE+KJ1KpU8hr?=
 =?us-ascii?Q?jbkAy+7C7jndPWYGIfcSe2uHz9qeYzIkHVZccSvrkD01dqSgQ0mDFivXRLZ+?=
 =?us-ascii?Q?mv8gw+7pihy1soRKRJG/gauSd0XFuDPmS6FG71kW6AL/UwWT7wIRZSXubPoj?=
 =?us-ascii?Q?nI+bB4rG3PY3p25KBzb/WjP3fdm1390Xjm8h6ZY2wW9a5k2cwkURW5MiQHrf?=
 =?us-ascii?Q?5YXXgdRZPiyBHP1YoSkUbytHPMAKd/cQE9zp99OXOUavQW+u4n5WnkKILsX6?=
 =?us-ascii?Q?C+Ne9u3HnpT+9pAUn3iohIdlKUn+aZEaSJazFtP3OsKXVLTmnvWY8urDvuq0?=
 =?us-ascii?Q?0ugJd/jIXaP+pgB6oMniVhJ/uhFeVN9f4l1cvAxebQguf0mkAtqB3soDtiKh?=
 =?us-ascii?Q?nZZQPnkHJ5RV5OpFTo0+JK+YJtXOWIbn3VetPwDR7nCW+vPmip+OcT0EpVQJ?=
 =?us-ascii?Q?gTGloha+ohikEpnphdne4DpMjDY3u+i9NWnPNsRo9O+PFklqKt49uFgImyjE?=
 =?us-ascii?Q?4uWLII4BifSkBcKAbUsiXtdjZ+iI5ZZ7CzwhW+M5SSc4mosLEhIPEnJnmUO/?=
 =?us-ascii?Q?b996eqNXq5x2cATMcF0mf1a0uHJFRBsFKiU05BcNGxeKcZCrFZmMshf/WCqC?=
 =?us-ascii?Q?eDX/R48S1tmEi0Rf8P/ls+mEjEFmLnvU+0qf5NUZ7DrhMfMs8NKqnflfYuU2?=
 =?us-ascii?Q?FsBUUkuwYKuO3oKFdELaS/5UAk/cHuHW+HZfWvQQTtJs6qdtz7Gc+/RfMYs7?=
 =?us-ascii?Q?z2VBkdUOSSI+bnDzk7zfoabmNsgy31UK3a84qHrPp/47OHfiu2lta9Hitnz3?=
 =?us-ascii?Q?zsndRRkqDXFPPxAHqPlRKCRSDCVZ7z9lr+VDWbJ5PqAuaAQTKFrLvzlGKRyE?=
 =?us-ascii?Q?rVq6A0MHSFmMlLu280aJ+oL+S1i9j8MM/ULnPbV8ErJSGCY2FyxUfVY8vkIU?=
 =?us-ascii?Q?i6Qp+atYbPJnXpnXrp3Zy0lne4xBavp4zEX09QKgAWSD6weT2i819XuD7SQb?=
 =?us-ascii?Q?hYltW/oMcJZLwPvskygXoa7g5GIzODhivabqNKyOURgRvczNHLE2gdecdyFi?=
 =?us-ascii?Q?/zigOhTk2yl6DoGxgKY2OP3aMPYnZuTkdo0dX6qEsLUH4jQ7nbD5+PNh28s0?=
 =?us-ascii?Q?hIECOFe5m7q1fg269doraXzhCDjNE3gLPzARK/ykpqsSbiS5DWfhxjU9TLuq?=
 =?us-ascii?Q?Ip9rJdNGpSH0c8B1uyJF3XmdxmS4EhDri4age4RWIbn0vuLlhYEyArU/duym?=
 =?us-ascii?Q?0JyvXoY8sK1RtHI266TBfqmyQk7FJpP+fC+NR5JvZeKfc4Q+/56JdWUXzU+N?=
 =?us-ascii?Q?LVmtEKqJj2D98HHhxEeajeaySbdibqm2ZwGtoppFlgG1q07hS2eEoWI6nJ/D?=
 =?us-ascii?Q?LM0Yd9ugEYE7EGLColok8PCwQRtvHQvsrxfTloyB8Jt3OCAoz3LGBUvwUcwk?=
 =?us-ascii?Q?xgpeTNwFF+U73xReFlVZic/D3qipefeHNXe9wINusuyX3yEyEJCxI2Oaw0fp?=
 =?us-ascii?Q?In7h6iloC5hE0YSrV4wXqyNeBZP3wrTtbAzQGxQqrCg2F2LLzAsxNUffxHSt?=
 =?us-ascii?Q?aIdyAbNXfEQ1SxsuzjFKvj7AF/cZymieMN6HspI/mVgt6lvBbbScgKx7/unI?=
 =?us-ascii?Q?zdhUbpdpYyb/1VM4MsPuEgiU9VxYUtnZunI1nf5Ss1q7tv7ZtPEimUIaDuaE?=
 =?us-ascii?Q?dt51yGRXLLpMZy/20MVkkP3HBh2t7KI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb857b0-7595-4027-1214-08da2de73efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 16:00:44.3567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +KofGsxhfYNs+kOTwQivuar7xDRc8rXnVL7eNMAEcsaMti5U1/pgUVc5E/qFwq4NUqaFLDSMFA/KvuU0OqMCjeQFQ9Y2YdVzuxnLNffab3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6009
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/05/2022 17:49, Naohiro Aota wrote:=0A=
> Introduce __btrfs_zone_finish() to consolidate them.=0A=
=0A=
This still has __btrfs_zone_finish() instead of do_zone_finish(),=0A=
but I think David can fix that up when he applies the series.=0A=
