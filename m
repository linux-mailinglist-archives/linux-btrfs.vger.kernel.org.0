Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22744567F4D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 09:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiGFHDz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 03:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiGFHDy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 03:03:54 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6EEB2E
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 00:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657091033; x=1688627033;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=T185kk7Ak49u7O3ltKAknoQ+t2YKks0PoGk+CEHi5jMgZpZ3s1qbWqmJ
   dLvkcUJeqVQfza+6ehYNKsbM5SvZ7XFKRs6FscW0hIby5RnGksuqhXx18
   A7BrSda4D8r9vgteB1bHLWrsxCjI+GmpTaJwNxQHccOWMzLX5j0IaMUcn
   8d42G9W8zQsbZvXbymxG56wEKN62iGjmM8aM0qBg1Ag1sxY+94YyXVVTf
   4O/iVfHgtuBW+4NbsaxJvmkwCG7WTS2R+CyvvYva3QjyTnRkzAOe/uZRm
   Zibr6qwWnbEuX3jYquhAUUzDlihZJAAeujtegzOj1slSsMSaMetdhCQKA
   A==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650902400"; 
   d="scan'208";a="204956173"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2022 15:03:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMnyKSMyf22jhO67QNJwxB1L6ebLziFBQGU0mzu+moEb4jxXh1FuRgcuO/TaIOi4WpfMZC0zlNNoyU5gX+6asoGAPgvJufRorjGDoIGVE+sOfzszIVnvgMt5HVPqCJkpCDaqXKk+07kF2Fe1ZjxnwmrP6isclgRQiijHB6FmPk5omA6fyyAGLnE4mCG8fZVfPRRrMNB+u6m1fydBTZPkDEwyKphvOLTWVzn10yd8WfVUsxJbE6bYQwUVihgamXUq0GEt0WC40JZw4gypIFv7dpHlSiNSBOoMgPpNvZ37mSTp2bWhVGr8SqsBFLTSbomPucPCx4GnMbsQLIbW8TIFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FfSK/xhtBVuQURVrWr5mWMFI4SKu03U6t+fKikHjf4AdUMFMy+5DrsJOmqBQl5yg/9t0O2VBaJZeJXHVNmuHl9RMDFA0p9XtLEqi6/OnHtMuTB9q0SxsTtLHv8l/Wkh7mkPIEGYN/vGKLeWlw+p2vBOwTcP/H0eVAL+qy7H1nL2Joibu75tHu8rCL3uPNZdVqKCOn9NUGym/z6v65Uf1Sz1U0BbGkiIsdl2LzKFWcmlI1VT3Kbi+yO5ZKkKDgXHDYqRIGyn9JzuFh/iJ+1KJNKf6kRuZMwrcWrAJ+Ad1KDwaTZujwlR7JbGR4xSFsKVBBJ6jkBqBCOKAapfhNg6G8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=yun4Vj3MdSZZZR0oVCV5W+U+9BMBmyyt65dDk6JqR3txTIILPcadWBgXMZckSCV2BWhYH+q4hna/rJubiiKGq5goEqXiEQxzQS8nlvLTfmPteYIDDYD3ah2g6dB+VkGg/uhcHTUCWqyi+urlwZbHz2Ib6C6+3ODSjPhkSc/nlXA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6190.namprd04.prod.outlook.com (2603:10b6:208:df::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 07:03:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 07:03:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/7] btrfs: move btrfs_bio allocation to volumes.c
Thread-Topic: [PATCH 2/7] btrfs: move btrfs_bio allocation to volumes.c
Thread-Index: AQHYj4JDP0mryNslHUqW98hnKdpD2g==
Date:   Wed, 6 Jul 2022 07:03:51 +0000
Message-ID: <PH0PR04MB7416FC6849D810595621A43D9B809@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220704084406.106929-1-hch@lst.de>
 <20220704084406.106929-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7aca9ac6-6a4e-44e5-bf10-08da5f1dae61
x-ms-traffictypediagnostic: MN2PR04MB6190:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rcuf82bOTzQlGq0tlD8ac5UNqA67oYsColizdbpMzBWPf+oNgvWJzlPesW/OVWEq5d1LQw5cWHBgJHU//niX7uPbH1AdsD4il5TNqXpPttAPISx1AhoBge/KEzugwCYo9RM0X6OzsOSrKTuBVqRWXBOkUyP3XQ7oJIvZ5noEbJrv30i2IqwGiaE1vZIgzn0MDcTR9lSXew1CG8u6OT/R44myE1WLmy2EFjx31z2fbfJKsNDmRr/rYRBevkMObyru8LCAdyoJMWFJ1E5041iZUTJMypdH8NNY2MQoPcB6PsVziI9CdChnXhVuX2WKwzxXnjJw/o158kirto/PNd9Aa2OKdkxGNE4LHkHVSk7ZqpxuDDCOZuZCJg4leobEV2+SuKsTJ7hGP/igb4H3R1zSGvqksHGwjAVmb758Cfwv3NV9Ojb3oiEGMsZedcG1EmGA/8AViyArYfXOgG0ZTu6og+REDJO4VKMyURrH1PKvBWs5UucfuzZv7TXQhIc+mc+UU5wJdnJVgvvR4UvlIino/UaoRdIn63jZ8CGZGw9gHj3GXHGXCltTUkhA8R03Aqvq1IvyemkBkd1bGfsTNVoJz0/P3ONRE5741Jpc+yEBEmHn7ToDGXMW26Rot0VHBaAcU5KWCOWaPCHC5XklIcWD6IaTL8l+tUcqG5hW4hwyrMBIZ54XF88pkNigw4pIOuStoIWn92M5t+7+PL21JNFKRXm8f+/51PJC9NLVkIP+3izKCoUg2AyoVkOChbu9I8ssriUuaYry9ZWsq1ZA+bLyigWky8IYEbCgkicrMBOZJl4H3tNnn5cPDSeChUl6ZfcF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(91956017)(71200400001)(64756008)(66446008)(66476007)(66946007)(76116006)(66556008)(4326008)(8676002)(122000001)(55016003)(9686003)(4270600006)(52536014)(478600001)(5660300002)(82960400001)(33656002)(8936002)(26005)(7696005)(6506007)(38100700002)(38070700005)(2906002)(110136005)(41300700001)(186003)(316002)(86362001)(19618925003)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SD0QMI0mDS4Wdutn/h9kZgy+ZYTt6dcKnARbuZTbXBUgN3VuEFUlKHROTZu2?=
 =?us-ascii?Q?F97/5TPdEF1cIP0564D1mnWllkXJAIRv8M0ENGTxTsMRJt4t9UvJy3jWKOvH?=
 =?us-ascii?Q?y7OVaMCPTAw21a+9Jh4diugrwifyLdTE86U5YQZttvauf7lg8l7rmirMw+9B?=
 =?us-ascii?Q?/lAZMWvuqmwAvLT+pCoWEdw4BvnQlyvDAhtHOyBLeNInLlpzlmIim86Obgv8?=
 =?us-ascii?Q?HTY2bGEJ9aJ/662b2KieczEvWHQ8Xm0NSqW8vVb+irDRYFtVrwZj89j47L/H?=
 =?us-ascii?Q?q6ERWCGx5F1YnY2xS2Sht6aJrjLgA9/eaLYL7uPGNvBTROAlNyX+k2vY7+Sv?=
 =?us-ascii?Q?2HAB8eP+V4pjpF1+SVMFXdYrqIhgedBepci81APwdpjno6VaG1iZv6a4Lg/G?=
 =?us-ascii?Q?YMasf9PEdVvRWdB1BcuCcat22wyQDz6H7eaCQuqGo8i0aWw7kTbXlDbGzQYO?=
 =?us-ascii?Q?VUrKbQ+Bhq+Vr6Y+O3D9VaQqmPv4T/nC3yY6IFZDBQYKpWbv0Wq9V0mV+nj4?=
 =?us-ascii?Q?tZNtYU9D5N2oJF9zizjhyS3IKtlihw4t68JOsQSso2SX56CSS7pLJEceoeS8?=
 =?us-ascii?Q?BxNcYrDD5Q73qPu7ki0XrhVhMfEqnXd4SWgqyb2hXN6eb2F0l508em2KiEU5?=
 =?us-ascii?Q?yBKNk+qLytSYYeIkjKAhlm9Yrybu0Z8OaPivmpoyCfAybUsRW0JjUATTgz61?=
 =?us-ascii?Q?SXgPqr/UJduWfnWno1GUKH9tc+XiF5i8kSmhdQEXyndD0/20CCGQz4THd3zF?=
 =?us-ascii?Q?LHclNmNFEODlN7NKvRd/BVBhDetRE4Wiv1i4DDrSN7jOzg2IumcwM1U+Ssjk?=
 =?us-ascii?Q?joMr5GMwRjerpNo51zqUCshVLn5iroSD+fjscOQRCgwVSAfLa2SjlJ/t7nzr?=
 =?us-ascii?Q?hUJwINi/CZNELib371fJmWE9PmUohxRjDkaAREgCOtOKAavLFeAUYIJKTfI+?=
 =?us-ascii?Q?dRVjEmC/O9EpAaJjC+MhmTt3ops+h7qn+9G71fzah6kkn6hG7B8BRYM2Jb+L?=
 =?us-ascii?Q?ij3XejtRdXBaAjNgLurETg9ZRacpNy5NOn6YcxQD2HJ+ztqy0e5whMTtJQcJ?=
 =?us-ascii?Q?aoM1wNiHXzE+7MVwo1oqDTCzRM37bvPgxZuhQVn3ehn0nVQWp8vPZfYGBxKf?=
 =?us-ascii?Q?U34K0PAVon68TCgKd3L+nHHn3YgxgbbP4Yl0SB3AqoJkPHW1JV2e+VCMe/Em?=
 =?us-ascii?Q?6iEliytItG7lEc1s5Rkspb/EDtvTbgyMSNTnH0VeuFGyXHPLoBQ5Me7kovc3?=
 =?us-ascii?Q?gyZyKryHNFw7/OJdWqGGa6ywF9cjCIUnfcg4wXVRbDZkus8I1fLd7JyraKRY?=
 =?us-ascii?Q?CDJu6lQsEiw63mUE5UBaKKuuI+1IxFXnMFNaghVNzrrgIzniz2j+zrgNqRp3?=
 =?us-ascii?Q?0WF04SGQXmI+kC15T/dGrg254wka9Jg4XUdpQyVev3Tp+LDzOtlbVddI5SHx?=
 =?us-ascii?Q?0T6ymo+EfmK90ex34vYSZxQpPcH3m4gou0jXBkC8CktszTf0l++7Nh+uVcuP?=
 =?us-ascii?Q?C8RdoNp6mUV9ocOfmCpQYfclU8lR4HGfALPHutGZy0Y6ZKxDf9adaibDMvIV?=
 =?us-ascii?Q?pNUJeFHdLioBeQ2R79JJ/uci8ML5oIJ2n0Jkssukf5npW/zlJRyKqttxKnmB?=
 =?us-ascii?Q?IQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aca9ac6-6a4e-44e5-bf10-08da5f1dae61
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 07:03:51.0209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhI2qZZQXBrmoiaov0bWCqAbMyCUKmsDrDsHg62PJSzstpqaOK0UDwUrTF7o6/mLrD4f2hWtZUIhzGuJx6vuCmAFmk8fcN/H7MBNcZyCSy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6190
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
