Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A955B9CB3
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIOOOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiIOOOj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:14:39 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413E064EE
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663251276; x=1694787276;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=pNkodnj6WQ1x1V19cpiTmV2K8611IzWfbj+5iMzv6H7v8CekW1ZA4AhV
   TR57FnQnm4TkL3vLU6MvkHro+wMsaXX86algQIrWTRe/y0E2MV+fpPZZh
   GFlxC1JdB+Mzugd1MM0MEIBWfV2UIJSABFuK7WDrdGy78L2mlcycjJzTX
   DexTUgwbHnmL1hD/y2nyZMSRRC1TiFeYBQB2opQKmqiYXi9uLCmuNbm3E
   HmeFFNuEdZI9ReTcHDiYy2MDAt2zNayN/2/N6IRwioJ9+RcaHWkfJCVPL
   AlDScmBQajmw9bgCProdiaVTXjwvEVFQ7XCX9OyWt5AL417tEb5IKNtMa
   w==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="211437911"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:14:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/ItSKNd925dSWz1gndg7VkewUNc2Hj2iCVCIfMQClbGC8RnTenxTxBEqbgGrQ1ukzX9FWZKj7X0MEZV6kBrYszmxx+R8n8Y1bmuv3wTqub9mZqYGxei8c9NLrbccEV67vfJAgKq+2pfgbo24P6xdctTU9ADvOhaf0EKbKZutD7Z/3j7H9/Cf7KtvBBSgRCDUaa6FUuLrzOlsZH7Pt8PQge3FkVoGKU6dmXaJGF/ybl47IRbmdpnNF8iWXTU7D9zJCI+WO78iMZ7cB0hN/XYKSrR58XeXbycKl8yA0ukY9U9cgvXwrIq1iFlUFsP+8e0ZBPSbHuctcV7ZlljCLUwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=G/tVFKpKb5/OUz6VMxbmEerCSxTJuyxsgHhPLsjWyXRRxpzUhDFmB7UDVjJCBVeWzo+exiix8TimYKAdcDeLumLrqmg1hFIoubKNsAhslaVTEqShWfgo3kudvQhoRmDomKzb8gSQZxrShqh0k6jV39IWEw2pU0gvdQWUjfkU28Ler0R0/upnpompsVEwFhvGzGHhdLfTW1RcAejnwxxgOxnf6ZWsdN4t5Ym1o/TnVcdqd7TH8tw0tx+6qNdBmJghENrYm2Ha4JWkWug+HmPmBerHHVGWcInAGFR/oWbgJLZEupZMgzoyPqmVKe1mmLdoEEdueR/O2QLSi6DjkxoriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=wr4vnu0bZc3NGaAiNe2lHyDjKN6JlvGpMVeWHo73C5yx6yTWlUW4/TQps6d9wMsGqHb3szskyKjgQI4vUdVybPPx54R1dqLqXt7z1GnrjcwX/rU3qS4PTyZcvHIGEx5zLnK4BiD+884bd1Y0wX5FdVTqdvWPuxD+12/gzSCgtHc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5539.namprd04.prod.outlook.com (2603:10b6:408:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:14:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:14:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 05/17] btrfs: move btrfs_get_block_group helper out of
 disk-io.h
Thread-Topic: [PATCH 05/17] btrfs: move btrfs_get_block_group helper out of
 disk-io.h
Thread-Index: AQHYyEu4ydaTCUtPXUaKudkRsDxRjg==
Date:   Thu, 15 Sep 2022 14:14:33 +0000
Message-ID: <PH0PR04MB7416E1C81D57398E40E534389B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
 <375729b0fb82db1991d42f26b0853f30a3c9086d.1663167823.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB5539:EE_
x-ms-office365-filtering-correlation-id: 7ec2dde8-d5f3-4493-e467-08da97249cc7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sEC6gI+CeAV/Sj5mPvoOoIfxQv7gtnXnZj+1IJ6axSQMjUveRSyKGFRf9OeUwtWn1OrkGZrR54T28E+u5UEt7LU+wTQXrxdSX1u6EEvCePsNe8ZlE4CJHcOvi44ZAU0Xrmv57duM4v6gNMlj3Jzz4+CHsO1SMcn+t/jvRTlbt5fTfBaegQyfvMIcipO5qs0aeyy8/qptWwj4mEcRXZCpOA0A1fl0UuirS5dvvcjy2lXJMt/CXJb22vno52Nzf+tx9VKGYC5MdBE1K6Q9yj8eE7svgxOPK9NhVYlXuDbo7ghWsyl7x9NeSUEf0CKsVnuenGuJeU7LMdM/mHABIU1RiRaL6cenE3tczpDNElgXsOxypnCCZ79xnvKy/mHTgQGJOK3EIpBDkBWDvLKUUzrgTo3tApnEGJpPaD3w0vi0ETj/r1zUHJa+UMiZ5LeB/A/+vvgVIneDAXyflp2aVdlyVhkB7GJloDpJdJMrNgvMk2xRSpZ+O8WdY5zJY3wdwG1uMTRj+vDHrQLEzzfjMBRQ4kCgQCWbdY/q414/Co+XlHIHcTVXuWXNlWMS/akGRR+n3GgqBhpiFBS3NxhzS0Lr8REvV4WYQ0h89FlMtSL4801aLAqj5JI5VRGmzo5yrlXq5w5ksUahFp9qhaWBdsKFOZ/DFZagvjLEVDC97TMZDS/6ZgbRoE39dOSpmMMGmbjQdchKVdUc3Pg3/ozgBzdQBRsfRUMZTx0kFahmAlbMfNK/rm/NGn0JDRfsINEMxugJ25u11vhpDEpy2whv+Y0gdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(91956017)(55016003)(38070700005)(558084003)(82960400001)(38100700002)(122000001)(86362001)(2906002)(19618925003)(186003)(8676002)(478600001)(66946007)(52536014)(8936002)(33656002)(5660300002)(66556008)(76116006)(66446008)(64756008)(66476007)(7696005)(41300700001)(6506007)(316002)(110136005)(71200400001)(4270600006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5oAoeAnfByHyqYhXIOGLHrRVZV3YCANishb/a8Ib51eFCtxcdCXKA7/TWNhF?=
 =?us-ascii?Q?RE7nZk6gxD5siXkTh5wDEGegQoZ/SM7V5z+cXGRFWCdw3WiCTxrm+PR3it4N?=
 =?us-ascii?Q?Nzann+unqt7b+17jnj8O/u3L9no6rqtQ1eUeAsg361QBTu18DCEPDOA9ZmZ9?=
 =?us-ascii?Q?W5jLqcFAcAEzok+6le58mp4p+ObVH7jTeXldqldiKsz9j4a8KRLx3Kgdj9xy?=
 =?us-ascii?Q?yIeX5oDbgXkgX/hETfxwhhIraFp2OMr9jQB5OoUOuPB8j1j3Y+zwtuC5c07C?=
 =?us-ascii?Q?rb0+W6LH7n3dpfK/sJ+vjH61KgsNQmulmFCtWyw8JmEQ8OtMow3gmd5mGBPH?=
 =?us-ascii?Q?44nhnI2lVA6jonCnyBx0y1lx3h7pxteSoOM/gTWoXIlB8cAKl3k8o59h9d0V?=
 =?us-ascii?Q?PAn1f506zb2VyOgjj8IFXmn9Pf+8ca/jcK28tpdvwg/GBDVXnOlk/caIroc7?=
 =?us-ascii?Q?BkYEvhmj7qHRbLJnE0zbwKa9r6SLBiW8eU6ZcV1iA3CB9/AhOz62k/Z2EAI6?=
 =?us-ascii?Q?4cg/0LVjxUIio40asK9agvUtdbTZoaE7hDy/eXjKmVLGJc7g9v4tfxdEKLC1?=
 =?us-ascii?Q?f6fGdyK2W+XFL799xFk20dEni5TOoozNBPb+rEJ5RvS6w1ccp+udPLB5znus?=
 =?us-ascii?Q?W8cBeEYtKrWf40GMLC4E2jhaDIzuNkoxeXQKZ60S2G9w240NvBfPIrDb2FhW?=
 =?us-ascii?Q?GNfJbBYlApwCBJktKpWCikUahi/HFO0kjYa63n/IhhMQzm8mPgt8HWT6Danv?=
 =?us-ascii?Q?/gSobc5V2h56XOz9k1bSLmPMnDXXZI/8fB7iQzNxRt1eT6zbj+Djik+fwt67?=
 =?us-ascii?Q?HfBErDNIKhhn52I8j5bOeisfwZlSdwqL4qGaLbNNmurQq9fcvmq2Dibi10rb?=
 =?us-ascii?Q?lyBzHPk+LYpc6ABcnFkNDYuebpKUH7XMSxA1PhwvE6VkxT0U2+oMey9tyF0n?=
 =?us-ascii?Q?vRzoLTUufXWaMkmYSJAPfOSWah/n0EqQSAnEsa45Eaul/+GQsUXd/dkvVBdn?=
 =?us-ascii?Q?xVHxwzDWzyDlXFx85Ms6HPqV/yv56ocoycpTQ+xuLMfwnS/7KupOIF3TCjhb?=
 =?us-ascii?Q?6vz2T+myQxBunt9z1hJlvylQBeTcjB8m83iAtbZjBJ0QROoQjd9Tad8456/C?=
 =?us-ascii?Q?OzlU/0qR7A0gDBSgocdnsSR+/PBNruBG4mzP1u4o+2eZIR78P05NcxyFACAH?=
 =?us-ascii?Q?v2dgMrGyGLLrpoIj07J/aHQm6Xfcgm/K6eQG2vozbXdq5Ho53wb0MxSQjCB+?=
 =?us-ascii?Q?kYgw8ztpZZR6Ius4Nkr3nHeUmYxa14YOmncIMUTdIGWJA9pA7GftQZz5hoyt?=
 =?us-ascii?Q?ViLyarakPizFFdhnpaviIg0To6AzLTfFFL53Rtd6QE9KujE6GHdq+odVaT4Y?=
 =?us-ascii?Q?ogWPwi05unISd5MfwhhkWSThMXkzhzF2a03uVXANOxmYukurGxCUeATZpqBp?=
 =?us-ascii?Q?UXQuUtXvmxj+LHoweko41/0ZD+Uum3fGMR3rpcuZYIJqwbnqdvPWCAMYRvDM?=
 =?us-ascii?Q?JEk4ADkINPdky1tChntgPGFuKC+pAk2Rr07TflDbZaY5g8qhhyNO7ys4fAOC?=
 =?us-ascii?Q?A0F5HOrhrtP4CrIo68IfNwQtUxQvlID/e5qniIncq0NupsJIfe802Xjqminx?=
 =?us-ascii?Q?GtXFU1L3TA218LcEDOmdyoxdZANYVU4aMMvhiw8GlikdBs8cBW/Xroonwqun?=
 =?us-ascii?Q?M1sPVt5H4HpxBPTeKYd4KvmGjnY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec2dde8-d5f3-4493-e467-08da97249cc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:14:33.0672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0v1QV85WKLuMZE7dN95cPkhZSpKao6AQXCOvzSWtRy5Y9Mqlb46Yrtpp+1LLpK4jJg1/AMhRUvqZEWP40w7o7evcR29YG5+T40B7nxc8Fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5539
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
