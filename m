Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7228C52A489
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348639AbiEQOQn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348574AbiEQOQj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:16:39 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE11BF59
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652796999; x=1684332999;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ItdMzsvzJd+1JynmA6NIcwXH1c0xcvPALUgXSQnJ/NE=;
  b=J0WrUbR/m4PBAbNMDiB4Z7WLxvXAPpIMOaUoE4sdkFMRmIsxdL99D5nD
   2V0/JXO5o528oWTvvHBJAzX3sHv12/7HWzjC+3gHgLFDU3gYMDX3jzLAk
   aTLQZd2KvXBdNrrSqPS+U4O7oh/pB4dxV7fj9kcNlTNeezNpd6Fw8S/L2
   UbJ6AM5EJYdAqFkN64w2eBhx8MRJkVBBOEcl2KRXx2t8u5HufdrHO3Lm6
   BJGtIH/pySHEDL6BxXL9sCDN7MKf793BaLkxhCDKxX92wUZ0GFo3JVr7l
   W53xANHORKg7RCOFRf2FNi5kY2mBeJI+2AwrC29S0knNMpyxw0PPciEcU
   A==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647273600"; 
   d="scan'208";a="201422149"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 22:16:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjfXhlCHgGgQFeqUtOlh0yq5ZLVM/pyNb0lrGoNDdJAHoWyU2io0LJ2bKRIiagQM02eIXqlTRSc6nt15tutLkgSiMmDQPjJcDMtDm5ek4Sp4yCKFfON5OXpklXlZ6tnse2A+CfRYHKpOLRr+2jz+GToOVC2cGKNVlmXU+1dby2heaFUv4Jnl/Bg9YhaXiTv9oeqg/Suq2aU6STgldx5VFkjPtpvWC2V3lBpGMAxWBSb7qratlx1pefCscgnmoS5xMAcsOVtlrtU83uIJ961nt6tDqAew7DkhuNQRGNIzzMJ6ErabzZb6ZDI6QVu31sn2BaqfeOYM6FNVthH6q9UlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItdMzsvzJd+1JynmA6NIcwXH1c0xcvPALUgXSQnJ/NE=;
 b=fxKhGyoS4b2c67sFI/NKXt9WsLF+tBzsG0AQA80+ETw4sgTjdy6GVRCLrdI0LuNbI4rC4KNtssAgQSd8xw/8eGP/i860y3BWsl8NBBqWaNN7G5i+EJRcTBBG+azzfW9NKEQumW2K3BtrmixPpAL3AleoXTlHTqnWH1+X1T2htivkwgs8nIMcXmpBgpMdUVRuP52wmeH8pKwuGQhKiEcAqZsALU0NDyLAHb7mFuLvhPDqr1t95hfsT5OkFmQM6Z3T2fwhD2si7yZNaXYhfbGywBHMhBL+KI+Av5+tAeDrUC5b23a/F0I1SFIQOoklbI7E4zde9lum96OSC+cWDILFkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItdMzsvzJd+1JynmA6NIcwXH1c0xcvPALUgXSQnJ/NE=;
 b=G/pbS+77CN6auG88jmTTiKBD00+RHPx3Ty2Nuq4YdyPjlDmS5yd/K9X6C/3lOIQ5tlI8gvnvRM9sPl/Y7Bhz9diDy/sZT9haF4HWEvGnqX0Jcc8LAzLd8GJCZD/ODvYyBBM+lB9/0IEu+NytSfi3c5JJ/iZPb4I8U0hbSqge8ac=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6000.namprd04.prod.outlook.com (2603:10b6:208:d9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 14:16:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 14:16:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs:zoned: Fix comment description for sb_write_pointer
 logic
Thread-Topic: [PATCH] btrfs:zoned: Fix comment description for
 sb_write_pointer logic
Thread-Index: AQHYacdThEor+0E8JkymSm2ZkIa8Nw==
Date:   Tue, 17 May 2022 14:16:28 +0000
Message-ID: <PH0PR04MB741637D53C52735F376B59F29BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CGME20220517082256eucas1p2ccfe36e5fa1b170be1c2feb90e867404@eucas1p2.samsung.com>
 <20220517082255.28547-1-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 264a7675-e4d4-4b93-a4a2-08da380fd5af
x-ms-traffictypediagnostic: MN2PR04MB6000:EE_
x-microsoft-antispam-prvs: <MN2PR04MB60001E4DBCC79A2A3E36BAD59BCE9@MN2PR04MB6000.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yBuC+l0Th3k5sfEGO20w+cE/1Yk3EEBUbZjoxu+7FQuy3A7U+Jdgaa+PliaAG5wcA6YvddbA7UlOs3/mUaxx1BDL5LB2GAxKcaZ59eLIqv6eN9S6YRTgaCKCNKSY6Y2N6zde97HGKgh5s2RqyiDFo+rqRiqVIgN4Gtia6HVg/VGR/2oIdQOrDE8eIspQVNLXnrHRFJc8zD47fqtQcfL413Icc+kYlhjcpeK+qagkj1kqlkrrpjiLbtBxwde2Td4uDf6ojQAUrKWczDSWOrGcabnyjN0sgITzTDi9fQPQjNwwGHBZ2TykHWbNz2nCL93iFJyv1b+Nh1mPfmcNlxqCaXRwsaT9RR5r7IZFI9IYJ69YJRWfYEjRSDa8IBrW38GGPXsKxZIKG9m0Kge36OujlD1Tf1ajvTbLNlyfHFvxy7aEzBOgoARgt/WcPvzimlfuj2NEx+QPzcP44EYWRt/SBKhcvwkXTsrp/4UaAM+2Wo+WOEUEXD/ImhWarLBuHtUbaOxB8LWp52MnpPZpItRsi2O7nZjQ4uoVJOSERTLC0YoWy+/P5ogOzzvy5aMPYjfMl2aiJVuTAbBNQXERW3aBjNzkB5UVg3TyBePUDFXtwklIzyJn7S772YwQchrc87+hD53rFkz5wug+o8yec3KgyEr4tpTJBiykk6eB57e6u4xYqP1f1t0xTpqHLM8/SzOo/68r463/doHdkBP6ynOThw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(7696005)(52536014)(82960400001)(122000001)(2906002)(55016003)(508600001)(186003)(76116006)(66946007)(91956017)(33656002)(54906003)(66556008)(316002)(83380400001)(71200400001)(8676002)(6506007)(66446008)(66476007)(64756008)(110136005)(5660300002)(4270600006)(9686003)(8936002)(558084003)(38100700002)(38070700005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qIm0RajVtW9iuRinQUKitrzfnrLESlHQ8Uzd1vNhj0wi2c2bzwWtT67QsQx4?=
 =?us-ascii?Q?4BST5uFWizmPZk1jwkVFW2rJPyAPxLJlo4sIT2Cs7x6GJuEks6qwJfRmQ+1r?=
 =?us-ascii?Q?m401xgWbdsxgnk26Z7XPOIxq3+vR5umh8MGGkoQejK5QxzJoNRGO4n0KXFU4?=
 =?us-ascii?Q?dY7SjZE3iAsrI75m/AeZmkiS+TCElbufGhTzk0tgNzLvdfty/JlmUfV3d1gj?=
 =?us-ascii?Q?d9diiWCMJ6svH1BqukYKIp3+Wj/Ms3SQjdG/Z4kUuPh3ixPKHUua4OFH7Y7b?=
 =?us-ascii?Q?Y4CtdWHKWCEAv/+cuIArsqp5G+gqX7ME7IAKsyY0EX23tMMKENvD4ftZFRNE?=
 =?us-ascii?Q?wRv0vhENXuU43EP1XU1d6l17H5+heTCdgx0x9TBEViifowydgruPwzaqpF9v?=
 =?us-ascii?Q?w/yEyHJpP7HwNk+ddYlCG8X41dKfj78tNA0AuL70I6dZwoXtIZYC1QsXNB4b?=
 =?us-ascii?Q?USN0xA02uMTczqdP16ycPVvBA2k+RoSJYYR/B4NoGipIfE386ntU56onzjTg?=
 =?us-ascii?Q?bpRI0AAeh3LHAn8iHdbOxEwyvXZU7KNsFKl2QJzuosy205j8cvOl7+KOOiCz?=
 =?us-ascii?Q?fVk+Uq4ZOgA5Xi0O1vlwwvWqDXYri9TRRMsHkhpv7cRLOW84TpRrxEGcMnOr?=
 =?us-ascii?Q?8HQQl+3JOsv7jg0xw8OMjICfn8z7lZl1IaZVnPDn6ghOHZi86lLSP364+67I?=
 =?us-ascii?Q?XV8RXyHhZnV5o24EPSfhTs9fLoyCrZg6/LA8tLLNysYyS9/uvCFAAb0MoOuk?=
 =?us-ascii?Q?/t13kEZrxGPO+LdEwcOMtAgsL+w0qvHsItCyVgfsUbtZulMh5pixnNORrQtQ?=
 =?us-ascii?Q?bX9frZifyY2w0AFQSk+jT1hhUiZHPA6VPT55OnMI2ErG+OW7ZrjFqDJq2gA+?=
 =?us-ascii?Q?CmCTArq6I+cILLCa8Mh4vi+l6UZB68K2uoulXwWug++lCwAQSe3Ka75OCnW5?=
 =?us-ascii?Q?KDDPvXvOFSrSSud3QG4qTz/Ss8CuqO0GPFEpFgoLf1n775tbxlYjymS0crzH?=
 =?us-ascii?Q?7D5y4biHdk8TSb0kWNVweNvSJh4tBKj49ECn/hsW/U9CQcSEmQMMJOt01JeL?=
 =?us-ascii?Q?jQ4GNOmeLjTIhXp1aLyX+SIZHwvKYkiHodQWn4Xhj3Mjq5OVVOgHHajssFD5?=
 =?us-ascii?Q?aieRH37pjZZrsGyQTe/FY3GZWW0pPOnwn6wHTvIUSfwBZy464nO6ZEANE7aw?=
 =?us-ascii?Q?ESLiFySGH944RzvxaR3V7a0eXhUI+kb04RuNebSQob2zgufz31Wf16stlIxw?=
 =?us-ascii?Q?X3+I2NjZK0PtbaVi75waO1nls+uTYVDV1TxrTBbxRXoatRIRycRKUhMii+jZ?=
 =?us-ascii?Q?71K/MMpvX3Nv4zkZmaxzgvY1K6fIUNB5sDMVhFCrCeoHRV7K4CF8QZWrieiv?=
 =?us-ascii?Q?Ph2axQo+n07kYcnIzVmNJKTfEQJaS3mPQj9S++ygd9pBldALCJAwPLMZwmcA?=
 =?us-ascii?Q?Mxg8WegXrfuxmkMx7UifU982TPcC7V0HuipUGEINQKiXPOsp0ID0ZKcWscKC?=
 =?us-ascii?Q?dvQWuV3A0io6wUBX8P/8PfI+uK6CnWnv6MzXwo909NespQAasFy0+EMt2JIX?=
 =?us-ascii?Q?UazILlemqJnl728KShKFfwrXqFOj32TYxSudSzE6ZRv6h1etcSFvZvjZqzqn?=
 =?us-ascii?Q?wW9ZoryTuMGqDoZ+JcdO9UfuP35T53NAPndRI5RP5WbMutwHwDtDpe/+w0mp?=
 =?us-ascii?Q?4upMTtzCFsrQLO6uzdI+RtU6K1Q5zURAmwHAUAxs1lWhg3mqyMz0l7/dzzZp?=
 =?us-ascii?Q?UiC5zGgsY9sqSmpN/Gxx0H/xmf6EDX9nJhMJpM5A5MluDIn0ulhsIR8dudZV?=
x-ms-exchange-antispam-messagedata-1: +7DMm/cvkI5frnIYBuF+KZBgQhSQECT57ozx3sQyV91AILVXwauZ2lrb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264a7675-e4d4-4b93-a4a2-08da380fd5af
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 14:16:28.5975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24S+w5ZcTvINg0EqLX24VrTfpow3GlCMtnVDf2e6xf5h++cO8QVqCoN6Rmr+AqURgqxJqML2j58Tv257K80basZYI7rWt/cqJSaEYlV+FrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6000
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the commit log updated,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
