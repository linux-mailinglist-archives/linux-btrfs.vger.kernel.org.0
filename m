Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BD75B00D3
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 11:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiIGJqv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 05:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIGJqt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 05:46:49 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71D9ABF0C
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 02:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662544008; x=1694080008;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fVM7Yud+mgnGBiyj/1mNOUJRnmTk7fi9DpLuJi+OPyw=;
  b=Fk0BFoAbw+/7gDLdzyXsFVz8xzCJBfYK/fPOANK7gSqVPw912A4s6f6K
   CBfGlLzPu5vQKvCBKDFOpGmHsYfKYTb4HdgqtBQVLWaYuInMxJDWwzn6T
   oXZe3j14FMAzfGEMz8SmHCBsIclQS27xXzeGOQ7Bmu6LLnCb4dwX8CPWV
   SST4bA40l8zxOukvMoNI2UDe4YbTyxC9+5cgLEJDcisgYIOTc+ViZ3Qt/
   AAA3sUu873yloCQSBgJA51o0XS976xEUmxmn13Uf8VgR9Z9+dpmDVKRDm
   s2PoJ/bFHjEV2giejI398/WzOSEtyNZnGwhJ2XN9CRsMPWi9Xt5w6K8Mj
   A==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654531200"; 
   d="scan'208";a="210723240"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2022 17:46:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYSfIo1m7cHMeJh0wYQZ/nbu7QtcLsiw3004I2Jk7GM7q1iVzcUTF4OQ6q08J8FqGJ0VmL5/cHdllxqYXOSbLqzthyF/3hCTu4rBPnZlo76QhdXGICAp2esWjDvzPpJKCG+wO3LRP4YbUhOvbi1U3ctkW2FDfBBBcIsovJvrVbfdcuMr9B8XhBrrq5HmwRfVDrTkB2GWVua9dWO+/n2ZZmLKeObOXj/kTH96vQ0mWDQjnIqEOtBaoWRpr7e6tbOKjphcLO9umlQnq88J1c/TSydUACbCfIIzEWrZt/58qCT+GFLcj+00o1Q5fuZ3eiCHTl6Al23UxPqI43UeOGwT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTL3T2LW9T+1UF1HkA5A/ZsHWUwviY/RIYPp0RiXlkQ=;
 b=Iq+kJywb4AJlge5BlCft9XKtUHhT1LbDpHsmxrBuRV3bKL5bJQMN/vocsliSiqdAEJE5gj8pB5YyP+VhoHDuprS00VSwmwzb+tBhFGMiwTTfkqhE1GWht1ph7WyaXzK0LIelDk0ilXcFSzB8uks72PTgJld+m+/GhZXiwdAoqzuRffUxvYmGP37DTwzGRdHENJwNKYtibXplclybKcOTgLSn4bWHXN7hDYESkYSHb4YpmtCEpUyINFu9AoYHl0Sl7r3Nthadlb33FNzC5uEOMu+gKbcKWO71Ax+Gt7UJQYuCQ5kk5N9A0TDbnuImf2+j9H0NlqILWirCk9p15C0wiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTL3T2LW9T+1UF1HkA5A/ZsHWUwviY/RIYPp0RiXlkQ=;
 b=cMVU/QqA2q/K/vU7nOmMNppNyjudxjD4eGIFf68SqR/1M1koFn0wZcTuJXYjEV/lCt4RBmm2aL+C64ziDIDJCKdtfOmOK/o7am+kn2HYVKXgUxWQmWjseLtv0rJATKYWpPcnVV/stJ3H2fr9w79obyYoKk1xYnWRlHVZzNQzXtc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5980.namprd04.prod.outlook.com (2603:10b6:5:130::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Wed, 7 Sep
 2022 09:46:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 09:46:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: code placement for bio / storage layer code
Thread-Topic: code placement for bio / storage layer code
Thread-Index: AQHYwpnESFyXKKAErEWmT6wq2L9F5w==
Date:   Wed, 7 Sep 2022 09:46:44 +0000
Message-ID: <PH0PR04MB74167C6492BBEE2014B8A0BA9B419@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220907091056.GA32007@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2480cae-b2ff-4e51-d311-08da90b5e000
x-ms-traffictypediagnostic: DM6PR04MB5980:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NcQ+2to3aNbok3I3cxckr7EDB+k4kAFF375Sp1+MW27e6r8C+FYHwWfZElKX2PpnPoxZD5F/erQ+Z30mFNHd7hJDOjYoTbhFoLG2zOcO2fCGaJBqpdF0QErDebUgoEC7CEI8ZcHPu/kmb4STlq1PQxhSatgiz91z4dWfwGppHVT3FeS8bT2RNPOExNN3ojDDOcpRGAbDaLEyEhuSF5iStcuZpBGW8L1fXkrZymIQSWnKSGt0qa66H4RNMTu8iaJYrVYrIlDcZCo4uFBVNpvwnce3FtamjaYjTVUopOHu3OYY5vExDXmTSVzw615AwJ9fJugyJ7TuPoFscHs/4Qx83f8Z0Z5sYH9hLga0PQ2O99Gl8nsuAjcYsjz+yQBiH1v6W+c+uwXSC9CKzk6tZFDu4k9mZLgJ9bsahrzdHDC+2E3Tk58r/x/JNOGDN3ZnL/l4zc4AuLXSW+oeKrGHb1xGw/sn67jgrBcMldzn4xhMBzfVyxAHkq7cN4UjTuBWJGWsYXo9L0TwBBCvteeQAapPsocBeB2mE4632Kn9OU5/QKMgFrcCNDZa2iXO1JShtM2ERKE0eCdhWS9iCTXDUMu4hg1Ji0NVM+gL7st84borg19OmnGjffbcPz+Y0xtZLMkNa/x3gGp0aK3eTiOuYgdtL+XDuCy5ebbT7yMx90XG76SdmtnLdlQHS8OlujeQtfB5euU4v6K5jvqRWN5+RKWrJ6h9qVUPQ52MJs/QTRg6ZwmQaTswFpTtEbgwnSaeQgshC14NL/54685ZIZl6LkjSVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(71200400001)(41300700001)(38100700002)(66446008)(66556008)(66476007)(64756008)(76116006)(66946007)(8676002)(6506007)(4326008)(91956017)(7696005)(54906003)(110136005)(316002)(9686003)(478600001)(122000001)(55016003)(38070700005)(82960400001)(33656002)(186003)(2906002)(8936002)(52536014)(86362001)(53546011)(5660300002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZrXy2a4vdjuQD6Xh0SQSyTgiUU9YzYMV3z0uJrCrSSyVWa3LGFwfqUO4Aj0/?=
 =?us-ascii?Q?gp9h1cGtfEEPY+CSGF1hMb9JH3fIngF+3gDU6SCm7eeyrrkLHz2QwtuUgY24?=
 =?us-ascii?Q?2r24BZXn2jprgxWOWMG60fIaMocWdl21xc2Brzm7NpW+Obv17YJwbg8kBEW5?=
 =?us-ascii?Q?+UzyV713RPME0/Cghx6wS8a5oWmTREkjsXQQ8X3Uwz3ClAK8wQlGEQS7iCJP?=
 =?us-ascii?Q?Fcls4fztB78apJKPxdrv80KP2roBgsvxU8aQjrlgYcTRSXXsBmVCKzu/8FJU?=
 =?us-ascii?Q?1cTY9tpHF0uOBk2W+y/7xQjD26+IP8CykFET/9VsxLUKap6ZB5ryzNW0gIbu?=
 =?us-ascii?Q?rJm4sqIVQG3xl/8NMJVsdS+8qHm1As/PMyHg9tJ2j8LwBx+5QV3MaRozbIjT?=
 =?us-ascii?Q?1RBWGBVA54aRNyAx5JXd1D16zSC98tGvn7Fi2eQIsHq0eQDB6oY1pDMkJTiQ?=
 =?us-ascii?Q?kKT6YIWs2+FhW8VwzFT4g8dBrLMUuYTbZZYAdd0wMTDuWgZmzcH9AJefxOz+?=
 =?us-ascii?Q?hkT7ql3SE/h2OoE1J0avj/kJSt3lurA/Y5FJkfx+v3U7B1pY/YQXz2/f7LFY?=
 =?us-ascii?Q?6QL9xY5PEoWZ/dPO7AN1xuvRCRcPssaADV2epLkCpXQw8/KGPYnd03HXvvuv?=
 =?us-ascii?Q?/HuFPvwFXJJaxSJruBGDG2KkEf1L1mFKqqpMqJkaUo+fOK6w6j89qKciCvfi?=
 =?us-ascii?Q?qi41y5y5CS21B9vBQNdWA/JQzK5+hLFkNMrjcR8EPVFpyZlpO+LOO+wwGNMe?=
 =?us-ascii?Q?YU56N4uzsw+xgNBc2o7MW1NtTxnaFNqY3t6Trlu5W+TfIzW9iBs3EVROsaEg?=
 =?us-ascii?Q?5a3wgGq7cPvkegZENxvQ/EZ4xLapZbCxDOEkiPfwHcMEOQTyghnz8gI16Aq4?=
 =?us-ascii?Q?B8/o/613LVelfShMvjTeVSpxGY2paVGQzXXCu9In6YQOVlCd2/60SuiYkFzr?=
 =?us-ascii?Q?SQcdIXf/wK0koQLbCgTwPlv0qtggIbLLOTexlnnNSwAi51asP89YEs/6I1BB?=
 =?us-ascii?Q?GZyV76pnNtuE/Gp5W96+G5Vh4BoNdbFSJhD9aUxtO7DN3jN8ScDhiXD2fCHR?=
 =?us-ascii?Q?0XYT6hZTqHqta2FGeySIAS0gnVMIJYh8BwBdzkW2Q0Y52YgW0P3ZNCOwphTM?=
 =?us-ascii?Q?Z/NRF9bKFY/o3BZU++xvcjI0r3wSg+A3JcLJimCtVnW6Hh8j2QVeCvhokXBy?=
 =?us-ascii?Q?bj2qqj/Y3MlpXDdUaN7i0LW49z03NWuEIR/+MhU76M45M80txmQGw4Oo0mTZ?=
 =?us-ascii?Q?vxrxy+bUZakZdkTyzQ3GSxbBMPI36qUhaBcJsWOPHcL+qap5AMuqVqkGiEfN?=
 =?us-ascii?Q?Q6fvMaQY/3MXhncTJE4cJ3e9yt3k2pChfK6/bkN1RI53cr5StS6VUS7ovMRz?=
 =?us-ascii?Q?iDOxaqyON2T494uw4unCj4geJEqEae2nBnkHTdAmYcT10HTrD7/+cki4nBpo?=
 =?us-ascii?Q?fhR2b7edrc1RSi2zJt+qd+59OBJdCZvNUNZWtGx8Rkmw8nLLLDPb9YvG9yVp?=
 =?us-ascii?Q?gtYbqLKJ5D2BbNtLQvi170ix/1rzsNjm1EoXWOND0RLdzQRRhkU6FH4/JozR?=
 =?us-ascii?Q?NfK3QfpmgMzN3ovygB/lN5QX0UN3RaWFvgVSysNvw/xmoYa/ZSfPbXKMQbnM?=
 =?us-ascii?Q?3GfCMd8bYLXyH4XdK5CN7fxdBvSu97MnXEgnUQNwYBAXLmQ5B0a5vzI/GrXT?=
 =?us-ascii?Q?cA2aSs3jaOBtu2wLxrC1sFSCo1w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2480cae-b2ff-4e51-d311-08da90b5e000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 09:46:44.7351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YSExvL02zj8vpY/I2AX+FgUuVRJBUZs6XJmpQAFW4d16C95IjicV6yqrP+wfYFnZHKS2xjBbcmThTBJhfnCjvwIENI+bDZeeIgIPxMHY5KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5980
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07.09.22 11:11, Christoph Hellwig wrote:=0A=
> Hi all,=0A=
> =0A=
> On Thu, Sep 01, 2022 at 10:41:59AM +0300, Christoph Hellwig wrote:=0A=
>> Note: this adds a fair amount of code to volumes.c, which already is=0A=
>> quite large.  It might make sense to add a prep patch to move=0A=
>> btrfs_submit_bio into a new bio.c file, but I only want to do that=0A=
>> if we have agreement on the move as the conflicts will be painful=0A=
>> when rebasing.=0A=
> =0A=
> any comments on this question?  Should I just keep adding this code=0A=
> to volumes.c?  Or create a new bio.c?  If so I could send out a=0A=
> small prep series to do the move of the existing code ASAP.=0A=
> =0A=
=0A=
I personally am in favor of creating a bio.c file. This would make the=0A=
code easier to follow (both in volumes.c and in the then new bio.c).=0A=
