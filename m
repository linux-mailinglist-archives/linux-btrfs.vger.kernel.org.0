Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA9F55DD76
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiF0GsU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 02:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiF0GsT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 02:48:19 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEFD212
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Jun 2022 23:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656312494; x=1687848494;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=DdjPIyZNncE4qaw1IDxZXMydPj6+mHz3wgAamA4de5CfN7RgR3iUn8BN
   BlfnD7kFL5SA+pbyZ70fYAnR+Ihw/m5jfcrjPK5Gn27+9NKMF0bhFEobG
   a+it+8sOZg5zsMSah5WWhMsI9b2EElZdZA1AUHcZLE6AR9L6pBsmbOoUJ
   wkjbbSd8pMWbhfR6eCdhkkkoRbyHn+a+rX7E2v/2fXXLvuA2deLHr+aku
   NdTS9gO/pGpiGMfpvrjCvp6dJqGZ1BOESoB0S0JvBD25QMZhTsqe2Wwcw
   q3OK4BfGtl8a7FdfMxW0xrvMaA8ikYx97qs1cEoN2nbiI1bUnRX4FxnVe
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,225,1650902400"; 
   d="scan'208";a="316276301"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2022 14:48:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aefh3CQWmxbR2TiphU5YAkHEt/zxTtOBl6oheYE3MvgM3DCvKgP2dBC0czlR4V4WZk+z26I8Xlzv0Fd+mDyr6EbJNnYpXjB5D99n5YPcPuoCSQNcXwVIc/Rb0k/CaZT6fQFQ8BAEY2Au2HOww8uDWfS4MPRqSt86uEN0wuw6bcsAmLdMVfkRWekVfi7j4LHTJt2OlB5CxURW0kM0cCXhaD8zYioTjUCtLjflrDy7m0umyR6oYd0NTCeVLHpWZrZnS6a2ANblN/qDHHEP3X9iVZ2lKS70iNF2GExqSjE5FjlKKv28V7YLqjW/lq1I6psQbMKRy5x5RWebOLdoonvrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=aIalXgCfKB13U6yfRlDsYiWiwrgXNJgPBScQAYjk3E+boaNQ/cC91WYxOo6QmLbN+M4hUrHqQ2Lc3Cf+iZqG/tKmWT1KDS32/AMDfhqVtHlFnx7nVmZyoluzCTbIylay4H3lODYRL9M1igvobkS2memU0P6/kFVdhASNDhE2V6VAoDddIgmO+XbwkjH4rltLJN3PGWAV+WFlwAt0Cvm0v51zGZlbsPu7AETlvK7g7mlJnt4kHK8dsbHtIm6B51uyVSW096DK0DwPaEKCHSk+cRoPPpVjs7r1L+EZzCmDO4O8MhNxpb4eu9emW2Tvn60PHClDKJe1hIL2a6BT9dUZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=qWixdn29WfQofdu86KQxBc+kH9oCpQ+uxUlA4Sn7YlCYKvO3H05ibXycWEIoh1BZtAFnfh3HVGSzFnD6EoN9CJYTfqbFBjl5eTsyajrO6ItNXghBYteU7DWE2hTb1Qk7vjo6kN2+Z1uyAKdnzo5aXk9I6Lw1dgfCX5xERaaidLI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5785.namprd04.prod.outlook.com (2603:10b6:5:161::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 06:48:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d%9]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 06:48:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] btrfs: switch btrfs_block_rsv::failfast to bool
Thread-Topic: [PATCH 2/3] btrfs: switch btrfs_block_rsv::failfast to bool
Thread-Index: AQHYh9TVolU3GT73uU2o87D+fmbj3g==
Date:   Mon, 27 Jun 2022 06:48:09 +0000
Message-ID: <PH0PR04MB7416D527953FDF18854ABC959BB99@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1656079178.git.dsterba@suse.com>
 <bf8fa9adf15bb078e3fc70d088d658c98a2b601b.1656079178.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 033799d8-d7d7-4cb2-9ae1-08da5808ff8a
x-ms-traffictypediagnostic: DM6PR04MB5785:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hCl9s1ZPUk9UHOhL8cB5IaiWN8zYMo4p3Ux0tFL1y6eo2rLb1H9qCLhvSRCMI0EEpAYcMdLgL74QlH9bcsYGVzDvZ37eqV8yK81QzgYWGW8jiapkTM97lz/zSzGOoeYlvpPA54+hIRWBWwvrWYMfx0VpXmngvnzzj1HRK+EKL2BqvU4UlgTQoi5yEwXWULeXN/bX7OjDwhs9ZGRN8QM8EGNJ3ryB66HiH5lyxMgi3YyeEFug362v+FFzEDE13rhOA6QnAOAIXUcRFfCT5x/a5Tr9YKZG7uT0LdC9sCNLH4fB+fF+9W83QbuTCl6G5hYdwHNkiTQNwIGJAyWs1tGKEjOqhaGcwW2QTLNyFRD8NdG6jb3w1PczGXCk0Ch/R2SEVUn7lput3pBxemgenHamLAFPdaAoEza4vjE7XKUWAugAVo9yHhguTSiznwTbyssEfAKATvrtLXyy+bHiPWIqRWzUJlkaP1L4RiJ5galQtfssGhu+poyofxiS/bzTwCQ9rmhwM8ENe//hLmP6SYXAhYTh1KdRXBI1huLIaBchMR2pnVofpf+CWCxLLMgCgb8U6Y1CzsdKz72mRNGqTd50H3nxcAef4XcmqHl+ZX+5GGu5WbfKi8uG0M7u7l4FqDf1kHAYGc+aYzC7RNYPrxCAq9D+APPTAN7Pd0iyf/Twpc65uzT1e1MrLKECxRZIYnZEcOgDBdqZqkoa6FcK76FvQ4sMXBCo8gIUICj3zKjC5dSMwr+CIH2tzGr4zBB6Nf/BYSxD897loITgrvN05O7Scdo9evzPFFWxy/j01qNZTiU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(110136005)(2906002)(8676002)(9686003)(38100700002)(4270600006)(19618925003)(122000001)(66476007)(38070700005)(186003)(66946007)(316002)(71200400001)(91956017)(76116006)(66446008)(86362001)(558084003)(52536014)(41300700001)(7696005)(82960400001)(66556008)(478600001)(55016003)(33656002)(5660300002)(8936002)(64756008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZeayventOW+neMi4qQ5lpm5HQaZB/gSfMOGzFXLGxHjoINazP/ihI1nFMjju?=
 =?us-ascii?Q?XJRnzlm7Bn2ci3AUrQRZvifNAfVmOi9r8POXu+BCQT0MDhADALcxieVtUnQU?=
 =?us-ascii?Q?lEqQ6i26dG0mnOSLJra+1VewrrMqBGYtzGsHtVL7WiexZaz6z7YXj8wBG/OK?=
 =?us-ascii?Q?5SZnYmfteGe6FJXmhNeHcbPgenyN+f7/CLxjA/evrJG2KL7Y3RfQJcAiOCp8?=
 =?us-ascii?Q?vtRzYEjuZLo5myfl/8xJrTeHy6rz7U/I8ikPZ8ZGycQ5SHfsodceHOcwCLFi?=
 =?us-ascii?Q?JirfcT0NAVb89y4iGzFHfYw5TvT/B1mqemp5FHFdEuJZ9Eu4UBLL/xgZlg1J?=
 =?us-ascii?Q?RezSxSga3mEjUoAJkXQ93uBRhQNgDaP8ho45QOXVtxpsmhY4IA9RD3kw00Fd?=
 =?us-ascii?Q?0l/y5TumwnNvK9rh/DNcVKqm3jyNmzVJiUSt+FypvjZqsKS88U+4ItXnzjrB?=
 =?us-ascii?Q?FZhb/k61Hl7kbPvWCozOdY7oPydRhrPGJnlpR895HY/a2RlY+oymMg8e25Er?=
 =?us-ascii?Q?Pw63V143ICWXv4wCOxgWpAIlHRFe2wpqETcXL4TkTKv3p/oNG0VNVlYh98iP?=
 =?us-ascii?Q?Lf2Y6qOBEseV11MC9ABcsiDRE8n+MWecyUIzDEU+VGD/aQ5bTZi7Bsx5pbG2?=
 =?us-ascii?Q?sQDf52DFJ7A9RCaB2bDA12KCoR0KFmj6ACqEb/DhOibZqpJZ+Atw6o4WtN03?=
 =?us-ascii?Q?bNAjuiT3pjOq99LUkf9dnBnMQMP8+//Fn9ZlLWJ41tmTSByemY9LxbbSmdDh?=
 =?us-ascii?Q?gMZJej4D5TiAOnxGoiofxJZCggmU2bBSQbJOqr+ABnnEX69qM2kWaz3vohsZ?=
 =?us-ascii?Q?w5ANjSoUxZLrPs+SszqbJuzhxEClJSxnmwU+kdiOLjdrd2UVcZqZxwV82Rbf?=
 =?us-ascii?Q?No8OyLFnSwZm4sa7IEOQF+VUP2IZUZvgp0Wyla6c2Y+uunPkZwSSJzgKNzGg?=
 =?us-ascii?Q?9Fb7oINqtH386vf2BxSsdNxgGnUVGUNHQduGUp80wSbX6x8ZYIp68E+2xN3i?=
 =?us-ascii?Q?2zle4z4ADuaXfiaXqGrO0IsJcFzFnE3txRboalkxVrOOnYhm2Y0cbHAylHPy?=
 =?us-ascii?Q?dTph5cbrl0IdbT8RovaA45hLLqMHBavsFuHN2mlNHWPe3qqPDWA+yZS+g+Qv?=
 =?us-ascii?Q?9jkFcfYZlzCqKiu9mKrmUaoNO+TnPdi5Y+bA0kzWmcyxbhK1cwXWj2keEPxK?=
 =?us-ascii?Q?zqoDqDZ297mbbepTxUTU8hBVfFWTpAOPkZU96vSOC7nfGlrGsY+x5D+MeV/c?=
 =?us-ascii?Q?E3hg8u+o6D9+sXLeWnB8By+nPopEQNQvHr0pnCA1mI9DOGV7itv2BfMefTAS?=
 =?us-ascii?Q?P38iaX+HYxxyrTqUEY7Yxn3zA+xZ5Px2ClhPKIq+pvi2oxEQ2e4bI0pBBRbO?=
 =?us-ascii?Q?6Km9d7xHZ4hureS/ooHYu8seyjE7L8IYrWXrvhJR5RsySpJLAuHqDMMFz9x4?=
 =?us-ascii?Q?FLMLLAK4ZnI0Z5SK84TMHPe1g8HhpV+4jvyblbA5m/XJruhlERQ79U5Q6q18?=
 =?us-ascii?Q?Za/3BNwusBG8VWNXKJWkOmIrsiwi/gZjKMMXgmKpnkc4lED6vLTwMKN3KuyD?=
 =?us-ascii?Q?kQJynfzzULbXShmB34fUmIF7NUyR0abxYUIEpMZ1UjyOSUYoUlQokHsH1P/J?=
 =?us-ascii?Q?Hp31RSssExWd/gEArdhGH1UZx6OlEtB9UAWMCPmyZ8Ss/onRYaZYHfbocZLI?=
 =?us-ascii?Q?SZ+iL6cDYKmgfNGH4ASfShhfQTY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033799d8-d7d7-4cb2-9ae1-08da5808ff8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 06:48:09.6290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pWJ7C2FMpowV+ztKu4ezYnPZ74GocOnx7CCCyEyhbAKbj/Hn/SKIyBFDO+bD8bbe5EQMP5NlyydSy+kpCrFVFiF3gFC5qD2BPCGBRMskYV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5785
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
