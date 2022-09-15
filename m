Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8F05B9CEF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiIOOV5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiIOOVj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:21:39 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86149DB42
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663251668; x=1694787668;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Xl05L3QPLQoy6957SIMrR7WNTj4CzihJbFmOBXF4FrK2pyI4r4XOR92y
   gSbbJZMFRT8vXPBKQnOIgYp00dBQsNSlj+tt0HYiSiv8k9BhD2ZylAO7q
   B2/NlLEBeZklgb27rT4NaE/i+y+imuXRVVZWg5mG4/nbybkaYypepV3mJ
   czsOFtD3tIff72zW7Jt0aEKfyHpmR7vrHZDVO5wpw5ROOG3LE96w5h61Q
   AtV+pqklYKebs2zB4JQ0YF/zO/jWlhIfwCR9qLmZt7xMI5aUZ4wU3FrDz
   I3nj/Hvk8BtiHs+sdKpoRzYY7+hNF1IyK1Gn6fwZvgLJis44/0gHk/OZF
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="216608708"
Received: from mail-bn1nam07lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:21:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J81aB+m9XwJRc9+X0lrmlNOKSrNnYTTRzBfqYQSAV1xvtKaxatQ4fYYa+gZjkSZtF2ZWboSJ139dCpxUmk4dVy+xXirLmH6HDEcEpLNB/1pLJ5IJPcibeJN01u1zEMxBSjBR+AJvNu4/5wY4y3qzW5wjirWJRREEhe8Aead60s/tSzl1M7ROY0JE61PdnNtZ2UshgZ4bAISKAtANYrS9x5eolkJKabhQSYDcU/at0wXWd08XgnfCckBpLmMtZkYP7GXghRW4ANULEp1WzhhfZGmFMVmfhW5x7lUfGoUU/t5EyewWFZfCLcg+gqxRVxqQSZ08PdGWTKfrg3mnvypCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jnp+v5S0a8Oku6CzIIJ++CfokicA4qXPFZtLNtrFCsK8WL/I//kEty0EpeXCvY00/q498vjT6eQMXMKlEUZir5WXrEZmNJZne6VBkI6FjVmk3QFiIXRma3VITPJw8DqLNfoPnMudjKwLOfXIfPmHSDcLuUInRWf1HN1j7SlTsYi+ve4hTavh3qnZgpofXCJU4ZtXSiCYYYApUitGW7iwYmZtgKq1eyuonh3UCYQTwNSco5M3Ub8E/EBWRpE/LD/PGTZdqjHJiVzkaEqWuko+BcmbpK4+gCE3YWEovPMRU/4ashY0L8Qhqd3JoshWUYP42MHxfF9OMryxeZFVSAX7CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=T/BShSlwzKJuFy3oOk2I/uQiXx4qE/sKnxf8rsRnOLySVsMdTkXGERmjbvsE0eTzl9Q+9h9LxQQRVq9tJxgGxungw1uatlZGz++xiu+AgAtYR9z8LtoSn+4IiRJwgiN3jQUEjj8D8c/Df9ZmDvPyF/GFIaNZTGBb8oqjxLKPAt8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6886.namprd04.prod.outlook.com (2603:10b6:610:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 14:21:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:21:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 10/17] btrfs: move btrfs_should_fragment_free_space into
 block-group.c
Thread-Topic: [PATCH 10/17] btrfs: move btrfs_should_fragment_free_space into
 block-group.c
Thread-Index: AQHYyEu5iW5vtbD/E06NTy9ACQnd4w==
Date:   Thu, 15 Sep 2022 14:21:06 +0000
Message-ID: <PH0PR04MB74166B41B5244DC6FD6CE1539B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
 <50ba0e87399977ef84a5d3787666fc6ce6c5cf3a.1663167823.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6886:EE_
x-ms-office365-filtering-correlation-id: 64ac94ef-7f72-4fcb-6268-08da97258766
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WWNOLuYwl1CgTVaIfuKteR/Q4GTYEioclV2W/hvJ6/QuxdvRAaFh3+ytXdgT/eCuhgSgJWcxDHFzHmkyzgpp0ayzWerHvClzMQmi/5uEi8L70OEL2hu2evwUI2ltwyuXkeBTAaNn0CeaVzXGB78Ub7uwn1/i7Wh0ZVpSKTL3QCNpPzs2zEGuRaoeUjDGJPxTFiuWDETCIXYZr2JAq6/fopZEBI0bXVYH+G8sQpJaRP0yMdEMIzEOYR9YJ9u7LTO/1cDg/A+QXADLny3+EyKGX7tlfbNeyK0QcKJjPuKzu9DV++JHO2lb2vZeFsh99iz1TVudRuyevXm5RDG3D8o5QRmnm10PWGkOw8/IbHhmm31vZ+foJ1UvhUn43bZrNp2hhWFsAGLFBN/m1oDb2pw4xUUkwOotv9swuNCyvBmNjooWJ4JYI47l/9lw9p1X6rUpWRV9ZAC+hfrjiIJlNO8xNFKA2LNjW51SUuCwou1zAcQBJjZ+IKeEc/YWzWlkp0vh/7G3IoCMN35yBviLguR2L1NHii70+lTHTV5KPtSQcdKy8CTsm5zXe+47M/8koTYtYCp3YA8f3Yj7+ImO/q13yR0tciR+0FWyzCFqzyz5pKP1VDeFQ4Abd8H0c0rc/WQY0Qjv08akiUlJLvUNhWIRSBqz/Jor9wYTk358dCQxsw1FheDxlXuq4SAbtA7dvOLEawXGM6HOJdo2dgDGFpcPdH9/NlUishG68twi1MVbLqMAZhRnNyqViBMmFq6/Bqq3B8DH5QHg4xhbKePaIKHYxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(110136005)(52536014)(82960400001)(122000001)(316002)(55016003)(76116006)(86362001)(33656002)(66556008)(5660300002)(478600001)(38070700005)(66446008)(8676002)(64756008)(7696005)(38100700002)(6506007)(91956017)(71200400001)(4270600006)(66476007)(558084003)(8936002)(186003)(19618925003)(66946007)(41300700001)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jtaxWd2v98S/owx/Y4AZdFTCEfkLRSO+ViVpgFmqlf/WqamL+5kw3t2/Kh07?=
 =?us-ascii?Q?eoLckFvGnQ0GswHNBTy7mXLDi3PsltI17qZvJqyOQUv2rXlvfYJrspT/q8IS?=
 =?us-ascii?Q?d60jpZ8p6iq/uZt9x9sHmKdqVNjiPXagPsJtcdRrl4CEZIe25vzaDiC6m6Fy?=
 =?us-ascii?Q?y5ZtpmmPCMgH8q6NMXibeFY9DlWwlD5kbuj/HKCFr5VLP5MtkgteP+g22s8P?=
 =?us-ascii?Q?N7LjxE9gxFtBolp5oRCL5m9sZcOLd+g07UXFFOaVl3F9QKxRs4LJdkwYDHQ3?=
 =?us-ascii?Q?UAvvLufqr24xVq9ZKh4oez7Ty8zavzul6HCRGWy+2CJpZzZ89K4SivN5THrW?=
 =?us-ascii?Q?LEvIEOTQ35WhKRclCKs29vnypZLqum0SN+6yI5+5DHRtzLadSGDemCoNsily?=
 =?us-ascii?Q?mZ7wXaE75a7bY8P3aZ83W+14MhIah0vvP+K+uPJZ869NLiJfviKinXjd2XW8?=
 =?us-ascii?Q?teDQpM37JXXiHIZ3JwMZmpfIo2sSW/h4pOWDsd9f06/H6LuOZ3ahDSm64MOL?=
 =?us-ascii?Q?KtwHFre1FMyfgaUt5NvS+J6K7oFpwQbCda+J0PGmHCbWk/g8DUsHrrIPUFvZ?=
 =?us-ascii?Q?Seky9rHNBvpIBICpKCC4Od39Or6Goi3ZboPXPsKz8RUS0cqmWuZa3a0zT2+/?=
 =?us-ascii?Q?Zd8IP4xO8zlMqNK/iRFDx+V4MZiHtBnVwh/J/9WN2436M+XO1pCK7GrNYofI?=
 =?us-ascii?Q?pkmxdQqAHYLwHvnoGLzrnUxFpvHCXh6utDt+ujR96gLIsukdYIXdXvQskojd?=
 =?us-ascii?Q?Z9RZ+/4/AQp29QDD6oBat/tiTfhWprhUsw2Z8BpGsNFD0IZNA3HkBEIlmQqY?=
 =?us-ascii?Q?2xAqGRVBnFBEk6AzT6aR9Vc5Of3QV41lrELFeK8URpxzojXGzpk4IknvhEiY?=
 =?us-ascii?Q?zcvvLOXXBWyIHySFqllG8ECYp2QJYy4AfClEtk6xIHPkjdIFuMZIXGb4+mmR?=
 =?us-ascii?Q?tVkMgJWFUiL1+TTH0Xq5gkKbNhtMQzrBrv5fsY34+rdTsWBBDIigUTn0KzBt?=
 =?us-ascii?Q?I5aRc7T0OCJEFmQTxAy4djBaBTLt6WT7PAlecQHegA7ZxYxQcDrFa16ltTMq?=
 =?us-ascii?Q?Tkoa45xWf3fy8WT/U1dkGg7dR5j8IkYQ6/2rs0PrBiQHuxgDwuxBK9XH/bHl?=
 =?us-ascii?Q?1YWhaIFULaDo1Jlzuy/IqntDfchnZpJ9eeQ6oatdZIxPpAQp36ACeKTkFQwD?=
 =?us-ascii?Q?Q+r1yjUroWQGlNQ6CV0hHJEMnnhojTgfsRILXbWJuTw0aUOAfa7adVnFebsI?=
 =?us-ascii?Q?tsJjufQQxqDxu6x+wZyWnayxIxVaNcujt8qjJ+qAzyu5FRH+a5o6XlrVd3Id?=
 =?us-ascii?Q?GLv6rMnH5sOXRB7c0zQ3qVam+NQ7pIwu9rLRBzI/hQt6MBVjd4u+bzro9oNx?=
 =?us-ascii?Q?/CquGiJGMMUk+TneriYWicbuTF5OyBUU2Ft0o4W66xWOiRobiVV9ctevUDuf?=
 =?us-ascii?Q?Ei3kSC6KlWtju8AzFMH+Wn1F0VfSiC8B3EVZpxyqTrgfboPYc9nURz4LFrXD?=
 =?us-ascii?Q?hmA1nS36GxILNtkQUny27crMjhlLBzzCGgkSvvAvQXa08CLVN8Y0nIg3mLng?=
 =?us-ascii?Q?kI8ejqlSJyybJ4esrMkNizvAAeYmG3DUus3n/YOrK+j99veJhusZDOJ9ZZVQ?=
 =?us-ascii?Q?i05U1qJZTX4g1URQmX704kyb4lkm/LP8puJZQHsqyuXxzq2rxftIGNUdFy8R?=
 =?us-ascii?Q?zcsML77pTNKX4xHL4vkwp/ee2rI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ac94ef-7f72-4fcb-6268-08da97258766
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:21:06.7252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlidOUFXF6XXZd+jtYJtPqyu3YZ3oo2VcNjiLwbVRWPR84u/xxGavidnOfV5PTmkziYr3qtFCb2piMHkMhmPWmAyEdot4zIbcVd0+XnOlR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6886
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
