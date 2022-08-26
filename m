Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537E15A2238
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Aug 2022 09:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245532AbiHZHry (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Aug 2022 03:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242447AbiHZHrw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Aug 2022 03:47:52 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249F5647C1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Aug 2022 00:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661500072; x=1693036072;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=BvmSryj16vrkzFN6oLHAUzF0sI0MKd/wpWjZ3Xr8+zbdq7/WRZqkgYWk
   Uw9/guzp2a1VPZJ7+Y4ePumSF83FXrAw62X5ONxlFDf90nJXIJ18UVT6B
   FvuVAS/I1i1P7Z3/O49/KXM0RTqRTeeJ0823rNgu81WuKVqb9bg/kngq/
   Zv14avFXT/7CghCktbTcaBo5HObupTj6yYjS0CdlM2SIb2296rgW+Zos5
   0p51qXDykJPVblWUE5SsiKvmco47uzOaxwVjv97FuMmEN69dSz7SUNSrg
   c/G1cQ+nzmelgJCN47oVE933GPZCgsM50/kymro3k9yRdSSd95tc2AcDq
   A==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654531200"; 
   d="scan'208";a="210224575"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2022 15:47:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3TI/zukjl+Grj1uW+dLMX4ZfmmoYeUuwTWUyMn8DMM8MpVF7IU7sRqqxNGlfPc8KZIlF2Z78qEhyyK0FoQS0lKlviIJUbbwWHVGjRTL8w7iCNFFZxAVRdnixVH0pzb1E12dvgkco39eQOoUlnEoI4sTXbTWGD2DLKyDz7F5RQz1+XIXu40BCBdl4X5Jtc1fF9HYPILPUiF+aG+4dPE5U0/L7cGXCuK4iI1gbPRLkyp3yiVvusoTdGPwY2y80mmvn6SqCUlkjaSTE4XjwEnOBm/bm/QorfvugMkEjBqrieHWHQqmaHaZ26eBQzKycRp9WowtEMYAiJygt6edEn4VfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hPbUUouBXMxg2LNKUXBFL7Ky5rFJ234YthuSQaX61KzcZJ+44QQ7NB58batbMzpVV8fglD22yicngEYZewpY/I8YJ5lV7OayTk3Ps6kx28Xgzi0Pf8sv7NNMEx+p/hvg3fFDN1b12Q8/q0fClepgq5fiQoZMdSAIc6ozVtqrS6/ugycyUGjhtd9JL+MvktrFCO+vktGENLlh7STcKx2Mi/nEg/7KpeDQ8+zQ7545TdEMmenCCMqNbJVxh5KQxrDjk8PPJA4hUGhhs6sxEZD0oFu9fCj87h2lFShZXp4NsLXfC5wAmUC6q1oddAyt62X7kxI2Qryjkot1fiVYYV2yEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IRj8DjdZtMXVC5+Nd5048WXZWcsy5zNv2dnZHi+R+fSDYHZgnr7u55sxBIgXp/OixPE1JOJc+8EfmKeI685T1izWTxHV63dy+Wk79VpgBmzTsixSigLQ1A5kD97u+yGQWVJW5mbqPm0P0ViCgyLjGb5iEbE9sgR9ofYtyzxhaUI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6116.namprd04.prod.outlook.com (2603:10b6:408:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 07:47:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%7]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 07:47:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v2] btrfs: zoned: set pseudo max append zone limit in zone
 emulation mode
Thread-Topic: [PATCH v2] btrfs: zoned: set pseudo max append zone limit in
 zone emulation mode
Thread-Index: AQHYuR9kPBpc3kug80yfn+mOJsyFYQ==
Date:   Fri, 26 Aug 2022 07:47:49 +0000
Message-ID: <PH0PR04MB741671EFCD910EE4D022BE399B759@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220826074215.159686-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd07ce19-08b6-4de6-ce09-08da87374616
x-ms-traffictypediagnostic: BN8PR04MB6116:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ga15eUWB63OLKdALfP/oKpdBNIXbmgQs2hZeamRdDvfXzG92ixD3xDjBBkxpVb56ceUPYea2Lozil5UPP10fqhEmU3ibyCGP3Age93yr9ivje3yKr4WvCE/H7uoQ7+bF0y1xvJbpCQqeUcI80OmCaexLoK5qnDYc5wDr1NmI8ENVmWGZ6/7SkNjp0+HqkPMNoqtaA9zHnLdmyRWIcBu7ec+6bVUeEc3te9vGYokwnHsAXIw5OsMswc0sYPBAgJFhia6jLKsLhTmRuh1Umaok8fgZnUiAnbEOvYDrSN0ucbSypPOHTFFug6374ELog3vVlWFAmiATLNuqBcZ5J+v1qi4mMd7jFU/Po3/tEWOGIp0lNzFeb8sRb92/90DCXLAKcHqGCovoTAaoOinBj/H2O8sMI5Oludq/eL8weyANb4XVNyIuD7jRGm3Ah7bojYV++dT9b9UvwvM7ptuuBliMjgKP7Wi/DiawUsjeB2iHRmE7riuwCG6n4vVulZXBe3/pDyzYD4b+glbKZLAy10/Maje2kLizdi7aMeSppmYx5VCIADGreWJ54Ck4uskUxjAqHcVpz5MX5vedxiEiu1c30C5DHpx7GZjqH10w3TvBytnBRQ9CPqrApCG+HiN9iIlkP7+D40ypTMgRkwbhL+BZE0YlpLLfUdqMam/4lGdnGqZIWyGdIYgCFmPQurx0ZoN6Bxe3pNoD6B92n3C0wYTaa0jwTSw3t5dR9tQ7Kte5zaBAoHa408+Pbbsp1ueP+05z1DtkKQP8DY0jaxpJ9Rw42Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(6506007)(9686003)(38070700005)(82960400001)(86362001)(7696005)(41300700001)(558084003)(186003)(478600001)(33656002)(4270600006)(71200400001)(52536014)(55016003)(66446008)(64756008)(66476007)(66556008)(76116006)(2906002)(8676002)(316002)(91956017)(4326008)(66946007)(8936002)(110136005)(38100700002)(5660300002)(19618925003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nB4bmqZ8xxigmoP4Te4sWsmfmNdV0v2AxExC9W9llMsceXnNnbC+YOB3EVkB?=
 =?us-ascii?Q?y5NOybsUu8ht5+fH7JaSOOJ8HP/evsZv1a/t/NzMBNhijOsiRlyHiBCWbfAQ?=
 =?us-ascii?Q?G6L7Sm7BH8hFb5Zd8BRJBnjasLDOTiRDfrpc5vm9Mm4bC8ZCxP0QIKyqjUUU?=
 =?us-ascii?Q?i1C6nN9oyTBtjJ0G68e3XHz1Ma1vCpTs9kZasr9IRSIAGV+hplzcv9CidxWM?=
 =?us-ascii?Q?PwBYboxht5gJvjwaXq5+PZ8iTY4lV1QPuqP5jlk6UFt1IvtQAA0Uv4ze2tca?=
 =?us-ascii?Q?mKoBM917QP3HpInvFgjTPRtYngC41+sNx4qI/0yxJg4gw0OTRGAutUPrsy4A?=
 =?us-ascii?Q?l/Nc6NEkt7lL494IZQZD5kt1MEI9/drc3MksWJOWlqsQG4Jz0Lso1PvGFJ9+?=
 =?us-ascii?Q?B5AKUo8Cv12uBZ8nQC3iBPMPaPO39FuVPRkhc0ib8jnvPoC6YtxRTBGzYmzN?=
 =?us-ascii?Q?wI1Pjj/tvZGQ/i0qWAdMDPeSlL/tnc1KvQZLLFWLmP/nr1EgogvilVD11zS0?=
 =?us-ascii?Q?VQWXOACanfv05zqUgV8+NrQJbmRCNzh3YAurnHYgvKSJsvJkzyuGrD66FgZt?=
 =?us-ascii?Q?orL94GLJn6VUp8GYZJvLLchJ0Qub4Z+YWObaod60YY5DPvm1NLg73DKD8y2A?=
 =?us-ascii?Q?vecnsGvsPXSbGTw93nTw3IBHCiuBBH+m/wRuxbDjjjXDUQ7WcZmAuEH+t2tl?=
 =?us-ascii?Q?u03kG+q2y93vthe6AzAMv+tpWMIumRfL65IiPjz4hNJk+ay/6MCCeDHFjXca?=
 =?us-ascii?Q?Qv7NuKg1ZECmhF4d78x2/VVSKuEgMJcRsGT+qZ21BEtsaGg5PvKJAwH0r3Pb?=
 =?us-ascii?Q?O/D2X1iV0yKBhk3mQR0OC5eLq5xMSlnpgam7HomhvClVDLlaqY5GD5GauiKP?=
 =?us-ascii?Q?VQnuyXeSrXNosUk/oNE35lRfZSiukbKkH1pqOLgShsuQwCLbMsw8xvkazz2l?=
 =?us-ascii?Q?KvKiE8bKIZ7b9VQLzjv9VAqjP5ZbKg4rzAm3joc+VRPMc1hCC5nJ8vTyN363?=
 =?us-ascii?Q?OYHg9C44gkKIuibcwOc5cGDWTu7i036aFb0AostjkP469nr4C/YtZkBdLevY?=
 =?us-ascii?Q?aixWZM3Y+cfXbNvVYq1urZkhkqHejwdLK4ihBL868QCX9HQN7mMwPP95L9+N?=
 =?us-ascii?Q?PPg5vsPm99KWwpiq0ttiURLnO7YFAVZR46tC8VHXWGnzo2wZGEZz+nJJd/Bi?=
 =?us-ascii?Q?pMYQfH5s2ETXSK/XO8ihenI2rRCdAGsFoamcLklyIkdpfQiwcUPHSyXmejMa?=
 =?us-ascii?Q?oPZJsLB/Dwj+3AftbbIZDm6wWyG1pN7DbMib+356eN+sC+/qZvwFgsfUWYQc?=
 =?us-ascii?Q?M8W/Ox/xS3u+OKr2BKmY/l4NjXoKvbeT8nZXTnVAcNpwcbJAhMD0zpYfYohb?=
 =?us-ascii?Q?8hDKkzDKdmyWJ1FSBnetBYGxWlFRheBlJzWruBUbTfoanS9WT+Dd+LxFvDfr?=
 =?us-ascii?Q?XKV03KoOwu9jTeGVAvoQ1wm3djJnMTd04HpIwdealBBLAwd2HrC5rCVxKWwP?=
 =?us-ascii?Q?rR8aQLt+mbbc1LQ/3U0EYbZywIUTnzezAOvQtpk8iqlHJfSV7l81gkRm+owi?=
 =?us-ascii?Q?BmHD77VY2/M1UGCGjxdrQwR86AgfOKGL/7G1Ve+xmeMJ1i2kLah5/4i9oPIQ?=
 =?us-ascii?Q?28NliB0nBdL6L5mAt60H5fT37Yk5RCqBsjwR54vEMN+/GdRbjo06oCKSBOs9?=
 =?us-ascii?Q?3CzDTw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd07ce19-08b6-4de6-ce09-08da87374616
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 07:47:49.4884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Np8Ix5uJDpVcm+3FStDSdVg3/9nbeeHaCpG1IlW+uunGAtHIF/39IxIswP4EAywqgp1iTLulsmf5FubeHrpVBYA7UTeNhPYKW4W5IwGIrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6116
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
