Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605BF627D71
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 13:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiKNMOi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 07:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiKNMOh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 07:14:37 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF561AF13
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 04:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668428076; x=1699964076;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4ZQ+XZTRMXyyFcTzHjvA2yTXCwVSj9UcFb0imInVmbs=;
  b=g+6eNYyXqhnzwuTH7sfg+O3AjQfO1JhE/tSTs12HeQXoMPjK7KwfCuPy
   qh44+cQwBXFL2MuFVNGEf9tFNemCzTMNoQD1BKdPSmGyU45h97joEDKFw
   mz2YYupI1N8kjCFWbyGA7et96Kwe95AOLxlF5inB6A81GX3gCQpgJ+tTl
   9LzysC3Nrn8EbVmbb57InRZ63I6bfZ/gUW6bgiAPhUdjJsh9+8jDIuhPE
   3rkxH3MzaSjz+UoaBH8FmtWZc9MnmiInN51KsYJ4ZOvNI4MOaMiDZ6qM9
   uD8zidzX1b2dDCf+pCwUMWM9wYxyGQCRIBv1HNllFYadrYcX8Jj/iKO6Y
   A==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; 
   d="scan'208";a="320559316"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 20:14:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIOeKzpoQbOj1TnzAXiEsXx9oqlATc+e2Cy44d7e6eIYq9N9CQGgudMfhjm5ak1jqjuHxr/6hSaeO9zChL+kgQcM10j3YcnxiLkLS5oU204Xdjh3N/qWN2h1YR7PPfw5rxUqsW39ruansdHfaGOp3Q2LEXbuqe4wgAJQ1NiNME29DpbAcy68S82ETFMvd4+LnhRKLtjqlOuX0DiAp6X0lNaVJTPZVAu6h6sZdq/ldfkbnjxz672wgqjvv6CgyIYxMUoZMKkYZHLCagfPofJVU9MYe8qVoY6eWcyl1pg2bqdOgrJruoPwAdtCpNLUwffole1LR8d58Xb+w9JRurHiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZQ+XZTRMXyyFcTzHjvA2yTXCwVSj9UcFb0imInVmbs=;
 b=XaWtmRhz2jxKHKa9cp17UEI8caKCRu/u+noklMgWD1mUfLjaHksBUUoCAf0Kbq2N0FjeIDMoX8DDFg92dwMFnaM5sltx6P3ySXyTts98Wk7+E6RTKgNhACX6XiRuU81IFF5NHO2KX9tyyCSYy78iTeYnHDtZQYtBpEWbbSHIHwhgnSy5VRYBGe/GR8baebdBZIH04/URuvfB9fEU2DBK/A89+tThpaI03lpuhP5HrhIe+a6Zk12uf+ECNicDo5yo+t35Cb/+3vYyYFdvDockdofYyFi8KFllh/96038RSRKSSNh+OrfklCtpo9gOcTY61jZ7S94kRoqLm9V/T48fOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZQ+XZTRMXyyFcTzHjvA2yTXCwVSj9UcFb0imInVmbs=;
 b=i80ZvXvXIi5w/IpIQ9Zna0de97sGAahlPq8zLocGUcsBntmQE9e9XFHuVHEOXl9fkhmVJRd2fokImJJlM2KsWs7DyFGwjOM1axLG0ta3RYLsMfFdXCluCBF+TdlXDlWAIydmNELq4AgzGEomuUNwmpOI42Vc5vCJYFsnc22FRUA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6889.namprd04.prod.outlook.com (2603:10b6:5:244::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 12:14:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a%8]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 12:14:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Christoph Hellwig <hch@lst.de>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix missing endianess conversion in
 sb_write_pointer
Thread-Topic: [PATCH] btrfs: fix missing endianess conversion in
 sb_write_pointer
Thread-Index: AQHY+Ax+ioYUwvetaEmiDFqVKzkcsq4+NBCAgAAhJAA=
Date:   Mon, 14 Nov 2022 12:14:33 +0000
Message-ID: <d88a9b0d-59dd-582d-adb3-82ed7c7f8106@wdc.com>
References: <20221114093531.1240849-1-hch@lst.de>
 <9af2fe36-038d-2bb8-7c93-2f6cc4880369@gmx.com>
In-Reply-To: <9af2fe36-038d-2bb8-7c93-2f6cc4880369@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6889:EE_
x-ms-office365-filtering-correlation-id: 6e168d2a-6c3f-4945-ab7a-08dac639ca15
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7nHQhs+qcgnLKqQyuqaxyi1O02xpIBdnEKbAnM+U5EpT8Zzfnl6fxYjgY83mFylgfozyT2x/pTmSEWABT+4y/KeLGqukeYZNjUOlSCcHiBZ9GtXd4nIOfhkbd4rGJQKwKBIQeHGFHEx1aOb70M4Ln0ptA+JBeNH6J0Jd8WRXHQ+7VdexYV4ZyIrycDZLq/xOWQImX3lUa0j1wjeXL8VUHki0qGHcuIWTVd7MDgDfIGrW7zfvk2Y64p0u5WzYecXjljdroaF6pDQtZTjLNHaetkyRlwQM8g1dz6PUQ9qMqomxPAoATa7t81DhMLCHO+QsyL5xYACgOAWvjnFpGNyjOlUuUwFVdNceXWJf5BAK8gie7Ep8YUzRxc0nRwx7SNhs7blbPV9S2EYTrLE4YdMmqLQmZB826M1Vht9Od2WRjk3JZPhakAR+rQbVS0FAl7xrllRBFx4SxHQ6XVEL8QIDQJXe0O7256eTb0Oc9lF9WaHiE5rzj6KcWG5MS2pL0S1Qc7IKV6ok454YMAgf7BsIyzsXWhCh6VC0b8pQeyzFqGAp7p7kgT/V0ec86USAHnfVyojywvvwtGYbSwRDQuMsR52oPQAsxZZVx1bq1E2+DNkxAyD7ig2Lbx3T2YWRIDCyV31Zxx43zBEDnOp9wyMgN+2x7tGmk1vQmoH8ztlNrBomKU8QrQJgxYasoDYFoli081hMA+PZ7Rr9A72vgE6FK1aAacr5IZ6nHdcwP/04ACvQO2RIWDGZCoaHkyha87rEOEjvDl6iEPLWevZsgZL7lR7dapv2I5S1xIuN4U9+THKwaSZn1n8AQxU4hhzvG2MOUVmKp/asBwyIRHju9nLPaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(478600001)(6506007)(91956017)(6512007)(71200400001)(26005)(316002)(6636002)(53546011)(66946007)(64756008)(8676002)(66446008)(41300700001)(76116006)(66476007)(6486002)(66556008)(4326008)(110136005)(31696002)(122000001)(82960400001)(38100700002)(2616005)(186003)(83380400001)(38070700005)(86362001)(31686004)(4744005)(8936002)(2906002)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkhzeHNRM0FOTkw4WmlZaVVURjd2c055WjBtWGI0OHpWT2lTdHBsaWFoU05S?=
 =?utf-8?B?NjFzTEJyc0pRZ2pBOFVUN1hjMWVyUjVJRjNEb2lTQk9JUnYycTBLd2xReWdu?=
 =?utf-8?B?ZllZRmNaU3dTQjY1eUN2QUtoMUo1VlZVcnlRUzQ0cTJYajh5L0M0Sk9vbUFP?=
 =?utf-8?B?N25GOEV0b3N4dVlTSzQ5cUV5dXhZSVJrUDlpeTFuQnFOS2JkMW9zTDNhM1Vq?=
 =?utf-8?B?QnUzQStscVBvVHMrNm9IRHNFWW44TUU5RFMyYU83ZlB4cnNpQjNMV2RFNjly?=
 =?utf-8?B?SmtPK3pRY0dNUGpraE5BVUhMeXluRzl3cTNReW1HVjRiSkdjKzd1WjdqRVk1?=
 =?utf-8?B?NGhIMHFNNGlxb3FCeHY1RHlCcU82dWxzaXVjcWlFYzF0OVNwemRsTHkzMzZU?=
 =?utf-8?B?dGpmazVrVStwellpQXdKMVNCKytxWDRMcjhKMVBtd3NXWGoyYnpRdDZaZzY0?=
 =?utf-8?B?UC91aXdTazZrTDdwRWR1ZEwyNE1wdFc5Ty9QSlRrQkNrVFg5cnc5V2FtSHhL?=
 =?utf-8?B?d2VQTGV5bWw4VDFoZEdOUHkwWDIwYkVuQy9MRW5tQ2hGY0xRL1pkc0N2M1FN?=
 =?utf-8?B?ZUxOQnIwL28rblV2NkFaeVY0SnFpY0ZQUzNvL2V6SmQ3dTVFZ05rVFZKUnQ4?=
 =?utf-8?B?NjZwUG9Fd3lYOTVwUjcrYldoNHFvTTZ3WGFoMTh0YmRFbW9vUmYwQVVaWUtT?=
 =?utf-8?B?c3Q4WVdNMmJ5cFFIbjB3LzlnVllNN0szalZMa3hQdThhZ3hucmZ4R2t1WS93?=
 =?utf-8?B?MmpzMDJGZG02bTg0WWFZSzAzbUVPcjJrWDZiREdPUnRRWDJDNEZCTXB2U2JQ?=
 =?utf-8?B?SzZwblBUSmxQMnF5TTh4QjFxWHZLZHB1YjFOVUFvMzVBSXZPTHNrWDB2RWNS?=
 =?utf-8?B?TVFXL2ZyNkZ2S2ZYYXdweW5qUkJDaStvUUw3dDZiaHpWU2lZaG1IbWdLRXgx?=
 =?utf-8?B?Z3hNaENHcXVVN1RKZXFxRmJhbjBzNGw2QXJMMGNrN2NyNVNKc3hnVHBlazcx?=
 =?utf-8?B?SFJsbTRjQUpYeCtLMnRlK2Z0MUh0cEp0V2hMZnRDUEw0cUpXalFjRHcxWWlU?=
 =?utf-8?B?Z0NNM09VbHN2YW1uSXUvd29WV1VUMEVYcjgwdHFsR2EzK2NPckJBRWkzaGRP?=
 =?utf-8?B?Mm5SUEZ3b0g5QUxzdkUxM2wzZ3ByaUQvTnB0NXJoSk9aTThNVzllR3dPR00w?=
 =?utf-8?B?UVRPZ1ZlT1hjR0drS2JDUklYcnNiRjh1Z2t1RExLWkF3a2liS1dpODM1ajBT?=
 =?utf-8?B?YlliNXFtZDBHUmNCTFJUbnY1algrcmxOZHFDYW13dTNWbVp5MFR0NEgxdUdk?=
 =?utf-8?B?LzZjMzNHaHJ0ZVI3OHlCRUFJWEpHUnJLVFpIZ3kzRWxLcEZFYjBzRXlRaktR?=
 =?utf-8?B?NEw5RUxTZDMvUW1pNldhVHBlWUhoY3JvcjBGNW81UzdZL0xNRUtVU1NkNk1O?=
 =?utf-8?B?dkw3SnR1bDFmaTRyeFFSNTYwSjFIQ2ZxaFlGWHlGSFZOV0xBVTJpTXcxUHU4?=
 =?utf-8?B?MHlac3MrM0ViRVo1RTc4Q29BdUdvYld6ZVZzemtyQi95d09xdUtSOGZNaG81?=
 =?utf-8?B?NnpKWkl2aTRLc1VMaEZpZ3VFWmw1OEpRTGFwd1A1RzFWcjZiME5HWEsrbHdC?=
 =?utf-8?B?amFoMUZpYmM4U1pOVnk3Q0N0YUpmR2xHSFh2U0N3UkpVeWJrVFU2TEEzd3NF?=
 =?utf-8?B?REljaSt6RGdYS2ZhRFI5TW5YZHJNNmJLbnF6UlZrOU5LRU5HV0dLTUEzQU1m?=
 =?utf-8?B?M1JZZHpHQUloTFFSUngvSFpEY21lQmtIcDROR2lubWFHWjhETjZuK1RITG1D?=
 =?utf-8?B?UFRhQUZkUWJNaXRqcmczV1B4Rjc0ZEo3ejNWMlpBY2dVbUNLbnUzMmVCdmxh?=
 =?utf-8?B?QWtiNG1MMHNzNlh6OXg1Y3I4ajA1ZkY2S1FyK1JuZUgwMFhWcUFPNElPZ2NB?=
 =?utf-8?B?ck1MV1RVc3RGdk9BbHdpdnBhcE94Z1Z3SnBtVU84b2hQRVMrOStmWEtXaEty?=
 =?utf-8?B?ZUxDMnMwcGVNYjNRdVA4dGVQdXBUWHg1ZUpMWGN5cHgxSnJUMHJ5S2hOTVBl?=
 =?utf-8?B?QUt4cW4vcGdBM2xtSGtyTkVFemlZWFk2aGxXemJWNmtCR1RWTDB5d2NQMFBJ?=
 =?utf-8?B?Q2ZQbUdINm1ZQUJ4cTBITytGQzJ1bjArNWFLQVEzUXZyKzVwSi9kbWFPMWcr?=
 =?utf-8?Q?cOyi50WzQGjfpxBXssl5/WA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <772F8CB326136F478828B7E335C68F86@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WbUwQHiMK4eczsX6BPwq5zUPuUjqDEFcNQLmeFLBYA+OKbWIDqbBeMCq+UFctOw92LxYWup5FhmCNeJjZSqeMgtPIxAWTh8YWE3PJboI0Npkb2ZbDEmjpLAMZiw96rkbWxHezvvUcMVpo5yOVu5rOYBgpxeC/Z3P8OSzKsQG6q0D4jhhdJsfJboFD7ngkojHI6UvubjDg+KLKzQd3GIbxKMX5iaK5YiSsZnbidT91+g8gA9lQnyFXd0hcWLWiRWjaeiBQAnyrZ8mxBY+TaotNe0tMxp39n/TYsh/lBtjVes23UMlGZQkyM0mqjxZW5kB51tewjxzgV5aR0Fg8WTOuuBCm2PpWz9ZzFGqePsw2LyzLaxQaL0E9+MUmewNBYLQbRcrnIWJLx9U7dfXroGkrNAEviHvTIZdsQamrti3A7w/jqiVq/0vMaOFIAbSH2ljU6cECzlZypYv9eae+M3Gcb8nh2YNZ1auVVjh18adU7sHE23llhFeYhWih6hm1vOlSdaKl33QM53D2j1zuBggrRqOb4MLcfFsM2MstXKovMki0AC0IRs4RNV+0/tCNze2yiZjoL6SCh9W5b32Zw+ZrEjQxPZzmyMY/8FZcu2Jx4Bu9o3odnrVkdhlHCDxopFdoc9CA2VHrtSeuWL0E5OZlnfzmjpCOg3CmraUujKor8Xs1ErTiDXfUPxZ4xRJXIW05o9r6MfIgTAtYkd8maJwF0gkcWzi87tQfDGdZLvUngUt3aQvTm+G678yu28huJrEuh/6Ma5+WGGGD1v8b0OZsEPs7wUOFGNkrjiqeHj0rcXZjPXYXf0toC/oOQeT4vVEYQR+fx2kWK6cn0VxM8xZ7zSPvkZ92Oc2r5gI8EjN03P/0X1JGRsixeBSdEJANSL+COqO2KuyJ1W2jHCp+qVUJQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e168d2a-6c3f-4945-ab7a-08dac639ca15
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 12:14:33.1887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrulCNaxdRhEKL/o0fbrpD0Q/EqvI3kk6pD8xhaP05AgRtyDC59EVyOJrCKDyXPalO1lLc765K3E7EAH37xf11J/NAh7T6H8oRKh40ykhsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6889
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTQuMTEuMjIgMTE6MTcsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDIyLzEx
LzE0IDE3OjM1LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+IGdlbmVyYXRpb24gaXMgYW4g
b24tZGlzayBfX2xlNjQgdmFsdWUsIHNvIHVzZSBsZTY0X3RvX2NwdSB0byBjb252ZXJ0DQo+PiBp
dCB0byBob3N0IGVuZGlhbiBiZWZvcmUgY29tcGFyaW5nIGl0Lg0KPj4NCj4+IEZpeGVzOiAxMjY1
OTI1MWNhNWQgKCJidHJmczogaW1wbGVtZW50IGxvZy1zdHJ1Y3R1cmVkIHN1cGVyYmxvY2sgZm9y
IFpPTkVEIG1vZGUiKQ0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBs
c3QuZGU+DQo+IA0KPiBTaG91bGRuJ3Qgd2UgdXNlIGJ0cmZzX3N1cGVyX2dlbmVyYXRpb24oKSBo
ZWxwZXI/DQo+IEp1c3QgbmVlZCBhIHR5cGUgY29udmVyc2lvbiB0byBidHJmc19zdXBlcl9ibG9j
ayBwb2ludGVyLg0KDQonc3VwZXInIGlzIGFscmVhZHkgYSBidHJmc19zdXBlcl9ibG9jayBwb2lu
dGVyIChvciBiZXR0ZXIgYW4gYXJyYXkgb2YpDQpzbyBidHJmc19zdXBlcl9nZW5lcmF0aW9uKCkg
d2lsbCB3b3JrIHdpdGhvdXQgYW55IHByb2JsZW1zIGhlcmUuDQoNCkJ1dCBhZ3JlZWQsIHRoaXMg
c2hvdWxkIHVzZSB0aGUgaGVscGVyLg0K
