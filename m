Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02034D1D9A
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 17:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348557AbiCHQnx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 11:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348803AbiCHQnH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 11:43:07 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5558E522F7
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 08:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646757722; x=1678293722;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cSkNrHEW65VvBn917dslngF69r4vqxBfhLqj0O9TuJg=;
  b=W8q1p1WQO8VBF4Uv6E/CbvreO3YBsdZ0p5FQTpgSGXp4qSeo4JFpLXec
   1DDeOfBvuwncJZ8nk/i/CuUMitGsJE58H0FPUf7pXmk89rOmiwwo+chLS
   IytXv0mc7ZOiR9ffxctNr5DfIGBFFtSPL9X4xSQHfur0ut3/s3P+d7/iZ
   UBe0V2EYkCMBiRbNJI6tljNMw/IXoo1/M4QV4w9jUaSx5qsFhN0Poj72h
   /WZ0RsDqcAq8iatRjaVc8Ao3wb+jmkqe6eZOZZfHm8/r4o2tg6kaHa4+Y
   QIKQzjp/c7xZB5nxtiQPg8Zc0UHnW7qDvVWllrfIs7x+fEChJJBPDfq2E
   g==;
X-IronPort-AV: E=Sophos;i="5.90,165,1643644800"; 
   d="scan'208";a="199617340"
Received: from mail-mw2nam08lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2022 00:41:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfYd0kaLJjnxYZGGk7TdD2ZFN8jcln7KvzrqbF7oZQNGsyhJSAazos6CzZgLsS01SHbfw8i/l+x0/etwiz+ZV9cvJ4xvRjyWW8Dp89FNIqlO23GCrKIGc1lTrWFvo8zY2jMMG5XTwzN5wP0oYnulmhR4dWie3f7EIywoWH2KV62mNmVr8BNuH+188O9XP6rKcM924oEdt4kZir+qEwJ5D26SBBwfQQD7CA+8rscT4CKogS1r2ABtt58VLnxij6an0s5GGjiNf04eSxzdARxZ7iFlsZqgB6w4CeyIrh+J3DZ+FETk36/S/sixVfoZKLSiTQJf4mSlc8CpR9+aKYIeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUlRYYRXBS/4aRzlR9cMjUJPO2myvFR8ukDw4BNrM9I=;
 b=QuGJCSVdKn5rxHRJQpebil+f27824GpRSwaLVNuRMHv0JMYpZMCbX8cIV6g5vK3NHmll2Af1agURFw/YdyFiIr44TknaDZLde59MDk9V+4tp4fl/5YANNslWAEZMhFtdat2sAgy6xGxzwFKaGuSmvwcGVakaUx6KRJ6pDuTErITSWr/WBgRu5/eJDszu1i1DXneDG58W4FfUxyJVRHKbxJQogQGja2cSULpkjHmz2XDIxhTEGB3JlqULY4PoZdpg57X97vuYjsIlpgrc/HCWlVs0ZiXrXXg8pmcZVASIzwNtP4xQvugcYqv63KkZi3Y2EzVJCnVMlU4FUou7EoTEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUlRYYRXBS/4aRzlR9cMjUJPO2myvFR8ukDw4BNrM9I=;
 b=HLwp/4Ih0xMCigu3U7MAt/BLK3KL9doykruMkbA9NLH7HE+2R3qulc8J5Ml/6C8ct2zebsB0itC/DPiLv1jqlsVgGKBqAIywxoKsmW8MiKJ3dUYYoCXONS/Hmk1cHm0riCpcODRtYmEPNlfWkInM/Bm4HRAmxkUouEXwRzfuWPc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR0401MB3654.namprd04.prod.outlook.com (2603:10b6:4:79::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 16:41:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:41:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v5 12/19] btrfs-progs: set the number of global roots in
 the super block
Thread-Topic: [PATCH v5 12/19] btrfs-progs: set the number of global roots in
 the super block
Thread-Index: AQHYMnBbxc+1QAT1zEiojmJWCfZftA==
Date:   Tue, 8 Mar 2022 16:41:44 +0000
Message-ID: <PH0PR04MB741601104CC2D56A2EF3C02C9B099@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
 <1c28a05081455379be5d91ee760f9a03e4255e6a.1646690972.git.josef@toxicpanda.com>
 <20220308161951.GN12643@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01f7d4da-83a7-4c6f-3e2b-08da012287de
x-ms-traffictypediagnostic: DM5PR0401MB3654:EE_
x-microsoft-antispam-prvs: <DM5PR0401MB3654E30833B245A53F8399EE9B099@DM5PR0401MB3654.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2QBbQPJkGp7AKaUqcw9CBZQHmyZwxoQFy+Nv6w68ir+IuCauFIuP2BIUq7/fl3c0r4hRmpZezaMrn9FR/THWIiNtHP9HCv7czXtDw3fnQSFlMYih8ptZgQ08Ll7p/urIIvttM0KpIKF9L+PfS2cbpjO7FCMs4Gi7F4uvh/hwQbXvQwvk4QaFfITa7H4EMQOchZKz+GAxncEsY3sybg3QI/aN3l9ev13SPxNhmX+vKUsZT8oA3OKKv6NGUU4XbhBO+oNta/8nI8T38BxQxpEvVb+oVFCxwWRX9Zwrf6b82ZRmtJWC9FxGcyKD46jhKh7WdqgMlRrWt+kHvsiIp1WJJzFSogEc0cchJNSp70DTh/HHM+pprUbYEenseh67z90Rap5KWYBNP5WBygoXaow73bqG1iaOShDZSx+XCWEtfiKRb3GOlcfiXp7r3/FqhD0eV1vE3BzAaOBEqNIn/BsosJfOvSyy5xF3cZyF86UyojXlD5/36ZBqeTGcRpP4Uy21Ybdl8Mm7AwCYTkqETBGr9U9hPE5aWdsvu/e20tjdfQApsnrYUwa/EuauzaDuuFwoMFb1oCBDuz4phOBY9Vl9V7Fihxhwcb9P/8AgWh8jT7xWBwVAwrAzdDhJZKQOYB2azf6ahx3cfEnTCKvpVAKzm7j34kjUYCCCUZDzNQmo1nUOIcrbWyVNaBFsAy0Q3GdZZsMvVzD+jikGJcugJlMNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(66946007)(4326008)(82960400001)(71200400001)(26005)(33656002)(186003)(6506007)(7696005)(55016003)(86362001)(9686003)(83380400001)(53546011)(91956017)(38070700005)(122000001)(54906003)(110136005)(2906002)(8936002)(4744005)(52536014)(66476007)(8676002)(38100700002)(66556008)(64756008)(66446008)(76116006)(508600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A3lDoIMUy9uSlJpA3BYnq/dexMouir70xx/nVVQauOJRyI5cpftTue0PZaTk?=
 =?us-ascii?Q?MIxvLTETXlYENaJZFb1zcwX/BU5jg3Jc9QtCAFE6MzKBZFyPG8rxovM5oHYD?=
 =?us-ascii?Q?+YMOoqpiKnkqt0JPhaOwrQ9vEOeGFk9LJ+5iASUBp6FFCroOzhHnZTnms/bO?=
 =?us-ascii?Q?Um1SVb+A9W6lf0hXMLr9bHzBzytEoOFCLHDusZ8npbg0TvTtCCMWi4LkCSyW?=
 =?us-ascii?Q?zXjpB1UmxMHNvBaS9O95tx37i63mZ46A8qaLtIrbydar+nhGr1SXRg3sondU?=
 =?us-ascii?Q?T1Vwo5McigEGu8BXPintQZhYs0+pcIw0EsYZwZYIgRlFf2eRFllQScIyWd3e?=
 =?us-ascii?Q?P2FR5ItWFhkyCB8rzxdecmvm0Kqd2hn5F0FygG1h3f9OVixFUwNaoLMyy8tu?=
 =?us-ascii?Q?YoTpk256FI4A7NsCYF1Cxmn4eTVMPsP4ZPkXD4A3M/vTEaR8TX5b4OCxkVpQ?=
 =?us-ascii?Q?/0l1Pw6m8Ef9WvS278tE2ziv0E++JfWlDnv434mIcGA4/oS3lc6beaNLzQ7g?=
 =?us-ascii?Q?3dYlRKykO34yiGCxe6H3Q0FBqAekKt5Ap5utHb9ekKt2cHLK1j1joIbzBVLQ?=
 =?us-ascii?Q?7UPttIxYDEyCtuSTdv8f3Mw7ylM925eN/hmBqMU6i+XFCZWg7kSagJbAUhhw?=
 =?us-ascii?Q?fgxo2Y+z1PC3X1kZ+P6QHR0Rf6T44YcoXXCX5AQn+N++1t86klw8Q34gsoxt?=
 =?us-ascii?Q?Mc4z/tHyQAMWnLlzls3vToTarLrsEZMZx30Hr6x039C619h9FoMmoTI2ZXhJ?=
 =?us-ascii?Q?iqRG+3e4dU9IsHy6Lzpvoc4QYJhYl5vCiYRPXtc03+NeMXsAdCO58TW2yx1G?=
 =?us-ascii?Q?bEUWjkGFfwxLvBEt0fp1Pb2hUdimyz5qJfPEiX26dl7oazkkQZnlmmo5nGck?=
 =?us-ascii?Q?VZTN10xxuG+E+tbKvI8WSM5H1ghoQE8tfb8n5m/LYIwS53w87WNALzLB0LFQ?=
 =?us-ascii?Q?3FJKJRIHFnAAWe61yZMox+deDPO7o5fn+LiSLy98O+c5D60X4iJF6pSgrYIG?=
 =?us-ascii?Q?xJAX3guaNGAOGVSohMD+uTYPhpTmiHG3eTFH0fQTZXO5fJWC8jyKKJwlu0Rl?=
 =?us-ascii?Q?Du9vnfs8AOtmCG0rA5/32j32uhQcwtdtFvFLehtpllK4TNIU/+M8wQWNmTgd?=
 =?us-ascii?Q?rW08yJt70weOwBTXoAqnEUle4m1f/eL5W1/9JmerLpim1MBzViTlMLIsdl3n?=
 =?us-ascii?Q?pDlRHytLpbDGx5AmPrvsRQmRCmqusQteAfXUNFzLcXpHbC3IBqi0wOsOayj5?=
 =?us-ascii?Q?91brlFUaIk17GSF+xNMIj1jSvXCXHilG3griLHsWENWQRWm/VFUnXNLpmm2T?=
 =?us-ascii?Q?yZxVOHO8gAm1b/D3UwujN6nnFMaUQPiR8oOA2YcfMdxwNa24mNfpAogrfLf3?=
 =?us-ascii?Q?LuHi4TL76kjmmN3S+sleKmspER1vMDllGe4XNBvQ7rFjY0ztZaSDlwmfAXcg?=
 =?us-ascii?Q?9lTFZL3B5z9SxI3s6C1LJ7qNkfJygvZjPxInGmwPOWI9sztTX4+e7ESykF3k?=
 =?us-ascii?Q?vqaEEVxZ4RMu0m2YO/ik0PJUFLfFmUnyKbUzKy5BarBv/z5zZdYj7vvHmfnz?=
 =?us-ascii?Q?vPD5ZApXPDtrTOJ9lTgkIhr6C+rGbHV7rjXCXHPk7SbBGoPcgzlzzYp/w1bC?=
 =?us-ascii?Q?3XRwtxMHPyd8jrmGuAcbAIUx7axAVKZPrWLnUjzTf/5fFmWnFf53QNctXqiF?=
 =?us-ascii?Q?xTNelGsrMa5eVl5+4qDTUKOvsrE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f7d4da-83a7-4c6f-3e2b-08da012287de
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 16:41:44.5414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uq8DDcA1QwnxptwLjGMJEtwldkqt14z6eleX8yIM1eAC+v5AeXVkYExARjwvX2/QWUa35wUQBIplGlYajz2v0H71jgpaK/a0+eaFFL0++FU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3654
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/03/2022 17:23, David Sterba wrote: =0A=
>>  	u8 metadata_uuid[BTRFS_FSID_SIZE];=0A=
>>  =0A=
>> +	__le64 nr_global_roots;=0A=
>> +=0A=
> =0A=
> Shouldn't this be added after the last item?=0A=
> =0A=
>>  	__le64 block_group_root;=0A=
>>  	__le64 block_group_root_generation;=0A=
>>  	u8 block_group_root_level;=0A=
>>  =0A=
>>  	/* future expansion */=0A=
>>  	u8 reserved8[7];=0A=
>> -	__le64 reserved[25];=0A=
>> +	__le64 reserved[24];=0A=
=0A=
Or at least inside one of these reserved fields.=0A=
