Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1456ABD86
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Mar 2023 11:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCFK6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Mar 2023 05:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjCFK6R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Mar 2023 05:58:17 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0875F270D
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Mar 2023 02:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678100295; x=1709636295;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6TkrIj+v/FOppH36bEpUljd9c+vF6zNUw2g412S+OsY=;
  b=qSuJTfCMJohZGWrIuv1Zi7o1cINA5S516cO3bJ6zJnk0F1DF5bS6q0WP
   ZvFFuSLNwboXnGCaj3rWJxUPCMsfq5fxXZbdLiYVNdRK3bLcusHMBext1
   SR+I37lOdwKbzVlbjkVlNBD2ZDj1eKIZLzOIoLug1p8h/kxurBkPft1fI
   B+pK9LjOxJTB3660BNZ5YpPMNB2Sf2aDKG144uCXBCC0BcpfZvcGOtehY
   eT9qT4MZTXEiylZjHPdYJc49i+Gz/79z61z+BLavLAHTG9/njn8CpIBVb
   g4lHAX4qxk1f0OTPZYslUHxVGNBNYDENP6Jhe1Ozj8NlvhLXVd08Bv4bJ
   A==;
X-IronPort-AV: E=Sophos;i="5.98,236,1673884800"; 
   d="scan'208";a="223179240"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2023 18:58:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVs2QLat4umD6I/bEzJjPeRBzr/Fzp1A0LLVCDrLNk5h+4F8jXPhUKqw3OtrYjH+yJAdXACqAK6d839W1/iD5QKF2izAOV0NQF4wPuaCvQIW+Zsi5FZmmqeyoP/4eBpSOakfedhCnxeWk/SYXofI5TZDfl0HfIqsrptlvJAw6P5IxSW84BAplRLW4IXzMVXwI0BkNbTVEoDR+U/+lRI7b6I4P394cRAoQVFnZwqpCZfZsSUfYTkVmazdrnh9e01Jbav2juVtLLC+/LZDzGpyXZSYq40y/H46VPcFnmDr5GKwtbod3JuK+8/Aabrx6mUvvemqBdnMBKiga8J3Zc1uwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TkrIj+v/FOppH36bEpUljd9c+vF6zNUw2g412S+OsY=;
 b=m3FAMvt6XsZhNNDltEl5EoTSVlwrYml4zwgm37IXNx2a3ifK4R50oNqCgmo4cXp5Pmh987w7pbIG92kJcZ1Bf8d9ryjanDEL770nWKmniMc9FKkVg04vfZgXfiFvxqnudL8h5GEbUbMiS+gJTd+F91semisbTrf3jvE+WMdQsQzVq1MdSg2EcQrLnVE1kmuVA5siolM4y/28x1Edjg7y18O9coJh+EWOBtqDQo2fWFiG9RvNBdxQuNjHyI0LKJszgRKPJ1N+1v8h6Y6OWZQ9LIfAAIzOmtZd1+fbbQ3w1+bOfp2ESqxavl2wxuBZfx6Y1gdMtXjtwQXoXR9eTtiphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TkrIj+v/FOppH36bEpUljd9c+vF6zNUw2g412S+OsY=;
 b=TQr/3aIEuzKfXSJiSfCtz8ZD1hpPhwRWHWIpkIFvq7IDg9bDm4Pp6UQ0+Lf292pOZ+3rIO5lLRViXQqC4Yq7num9sBuRMy4U1eD+dsI+2XNe5yJ+sI10ZjhiKRjadl1Si3a44uPcJj4+IgBN97ncanlLCNWRPOdcOfMqQ1zcras=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0962.namprd04.prod.outlook.com (2603:10b6:405:3e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 10:58:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 10:58:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZTOvFIu+8wyTHXEOnol2yZkL+G67nUggAgAAHeYCAAAWhAIAAA46AgAAikQCAABkfgIAAdl4AgADUNACAAAeLAIAALIiAgAR+OIA=
Date:   Mon, 6 Mar 2023 10:58:12 +0000
Message-ID: <71abae10-a936-6bc3-585d-aab58ec3d3ea@wdc.com>
References: <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
 <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
 <ZACsVI3mfprrj4j6@infradead.org>
 <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com>
 <48acd511-7f69-4c42-44ea-a39973d57c98@gmx.com>
 <b538f61d-fda6-2ed0-9a17-216506ab2692@wdc.com>
 <839ea665-7fc0-334c-e289-deceb417c0fc@gmx.com>
 <ZAICY3zay3LLjovf@infradead.org>
In-Reply-To: <ZAICY3zay3LLjovf@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB0962:EE_
x-ms-office365-filtering-correlation-id: 60f389c4-e55e-4196-a011-08db1e31ae03
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EU00EIOnZLSDlTf6bgZG3BpXvubraVwFraBVKES1ay3X6TiD3b2YIocb/Di8tOAeVJtvIXVAz48PNFAiBQKOe/skU2Jt/1xNOzFSgI6auqZnlP+wMW0XK1OTQLSK7TOcYvPlK3ATORNkEbd52Ol/kft5kpszBZ24DkU0uAZ+yxAz0Dn3M8UiHVYCNOE0phqmDuO1VN3slmeBq4kQ6yI9L2Y/bDXUt4UXsSAELwElEdshiEMQnUQh6P49z+PN4Q0PWC5pXxR99ZVa0of3L1p03Fx27L7yErX9LtOCDGzCL+H8EDZTCkhqoJ2290sTGrlgSuPYeuHMAvhUtjwEIJjYiaZ12MWILsWKtAZAuzhKntExedBTVD4NNTLGo+RHcUrNnjH+7tuFTK8uUHteQ9wYYRwE4xT00eVPYIqwMDF4woMpAgX4LM6GNoKk7/whohQUv0fb+gPCMbwd6Mk3g7Bx9gBX9Df5y3sv/ghU35d6EHqByUFs4g8pwSfii558N3jk+bJdvY6hcKa3g4HWhk9GHrB6L7cj86iYNTt3W3fQlB5jtcyn0/EQsiTycVh+MgO3pbitZvB3s88mvqfhb9S2H7q73kzf8C6Z8+J1Mz7LtDiw4LYqHeDdpDL7FJNFDo10pzW6HGRi8hFDNFAZ6ulmpXMX4jhOX1orfsTktb1stR3SGvYD172cMDexi/odbzD+MD1uufQIuY5Zro3yOcz2CNdNm3vczaN2AiP1a/t/39IK48iaoKx5UjzW6m3Ca3YF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199018)(31686004)(110136005)(54906003)(36756003)(6486002)(966005)(316002)(83380400001)(86362001)(31696002)(186003)(2906002)(5660300002)(76116006)(4744005)(8936002)(66446008)(66556008)(66946007)(41300700001)(66476007)(4326008)(8676002)(478600001)(53546011)(6512007)(6506007)(26005)(64756008)(2616005)(71200400001)(82960400001)(122000001)(91956017)(38100700002)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFBDdEx1UkF3RlBwZFNteUtqYzlkQjJoczdSNnJnTTVSWHJwL2h2eU0wZjVh?=
 =?utf-8?B?b1FGR1R0dm90eDgvQVdDUlQrOUtRUU16K1FCbEdIdDRZR01keHFnRzIvVXVh?=
 =?utf-8?B?Q1NINmZueHBucmFQVUV3WDNXZmFiYnJ2Q2Q3NzdxaGpCVUhLbHRROTJRa2hz?=
 =?utf-8?B?NFcwVzhjaVlEYmhza3FIdllaVEtzVEI1bVRpRVVPN2VhNVNuaUY5VU0xSTRE?=
 =?utf-8?B?cnFyRFNoZGkxbUpsTVYrbThLSXUwUnRqOXpKQmxtUmlPcG5FV29sK0Jjem1U?=
 =?utf-8?B?dkJyOXBlV1E4clN5ZWhYVnN4QnRFaUpRc3pMZEt2eDdPb0FoK0tuTzNyZU1Q?=
 =?utf-8?B?aE9xc2JabTFybVJKU0ZkNnB5QnZvWXBzVW4zb3h6aXFhdDA1ZnpNeGJGVGgw?=
 =?utf-8?B?YS9EQzYzMjlNU3RPNnpPaVd6ZDhQdGtxRGJIT0ZZTHN6UFNOamU3OUVLeGcx?=
 =?utf-8?B?TWg5V0JGd1hUUWFJMWVhU3dDZDZVT0hvd0dNM2JBTmdhVlBjS2hYd09HVGdp?=
 =?utf-8?B?bm1PNk1oaW5oLzkvTGowQ3orUGIrbkJqT1FQK2p4azlTcURheFVFeFpnV3Ay?=
 =?utf-8?B?VWxhL2d6K0NxQllvUlh1Mm82eHVYMDY3TXh5UytINWRielk3WjgxaHFUbmpr?=
 =?utf-8?B?ZzZnaTlBZVF5cVo2U2kxQWNPenpSSmgwYkd6TXNFSk1FMy9rNC91Ni9GOC9q?=
 =?utf-8?B?ekdqSWg2WUE5NldVVVNpMjN5bHdwQ0Rwc256TSs3ai9MZURvS2w0Skt1TW1j?=
 =?utf-8?B?bTY3SlVkSjl0T29YU0JGdk1PMjIvbWJLVkVwVnI5eDhNRzZnMlZ6c3I0RmZn?=
 =?utf-8?B?RjJITE5IUWlqcXlhTjkyVVVoclBRNUlkZEJva2ovQ25mMVpqRU82S3F0SG1X?=
 =?utf-8?B?UEFSenJKWHp1cDliekg5SmVhWk5EOHhSM2Z2Yk8rUjNWdnZCWndDVDlZYUkz?=
 =?utf-8?B?VGpHWmdreEJNcytqRXk4d3JROWNnSElKai8rQ3BkQTVHSmZLSjFIeGN3c2Rz?=
 =?utf-8?B?c1kzUjEwWERidTljcFo1aE5CK1VLK2tRNUJBZFNySjEydktpV1hrMnY5MlIw?=
 =?utf-8?B?SCtWYUxlYy9jSFFxYXd6Ym5aSUZsKzJuWk9IU294dXV3bEt0YXJwMDI5aEgx?=
 =?utf-8?B?VUdXd1IvZFV0UThVSkpuWnRVM3BlTURiZ3ZteTdlZThGcEdxcDlJTEluT2xj?=
 =?utf-8?B?Q0lsMW1rVk1NY2xKaXZRSWZzZVd1Y3F6Sk9zbTJBYTlMRERBdlVPRUVsdGd1?=
 =?utf-8?B?OGdEV0RhSzVuYjdVL3krN2xIRWJrbGtMNDlQemt6TE9nSy9YUHNUVnFSSHN6?=
 =?utf-8?B?ZkU1cTBSaUgzQ1RtamF3NG0xRm84R1VrVEFRY3FaUHpMMjhGUTRsVWE2eGIy?=
 =?utf-8?B?aSsrNnpZM2JndGlqeXpaSCtVTTRwcXRBRW9hUnptRlpBbGNsbTFkekQ2di96?=
 =?utf-8?B?K2c2NmgvMlNkNzVmSVRUNU9DZ3JiTXovZ0FCVTJqemhCYi81U0FFTDRJRDh6?=
 =?utf-8?B?Q29ZMzM0Y3c4dUxzUStSakRMeUMvYmJMN0dCZVdkVWVjMlZteUhxWXhYcVpG?=
 =?utf-8?B?Q0h1TjZCVEZhbnM3bG8vcUhIZTNXbUtEQUl4SzNFLzBlODFZNTF4QWQ4Q0JU?=
 =?utf-8?B?MUlmdXFLQU1rRFd0aXpwOEQ4UXVoZ242MlpZeHJ3WFZYaDI2WVNyNDFrRHZn?=
 =?utf-8?B?djFsbWpXVXFYTXVOWE9SQlF4UnhtNEhiaGg5ZFdBNE1lV0JzZXhyZUxZU0w3?=
 =?utf-8?B?eUcwSUZGMXVPa0hOMTNLZTdLWjlRRUJ0eVZPOWhHbEZjeXgvM2pxSUFaWVA3?=
 =?utf-8?B?dldsdHlTMDd3RWVyUStiOUp4Vm44MzA5SVRWNlgyRytUamExVGxYQzBYWnly?=
 =?utf-8?B?ZTQxdFk0UklzL1J1ZU40K1l4bS9wMHZ3ZC9hYjJpTFlVMEp2WjVwdFBaUWxW?=
 =?utf-8?B?aVBaNEk1bUtUcEVsYzF0dXM5bWdMMzlLNm1GSXRpM1Q4SWpPc01ZVzVuSzBx?=
 =?utf-8?B?TnFOa0w5M3k4bzd6TnhscGJ5ZnJqcmthaWNQc0paSzNTVnUvODhvejgvQzMv?=
 =?utf-8?B?WnhJb1VZT0M5THkyUklwTmNkdGJjYk1XRFpWYm5IVUJhekJ5d29hNitPUGlp?=
 =?utf-8?B?aHJYSHBiUjdPTWxsWHp5ZVkwT0RuVHZFSGxVRXAyMU84bnpxZkxSUzVWWTJV?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C21AC49CF596741A266DC803808146B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aAB4FARrvQvdeMFufvTYl/yX1BzQKQhyiacN3EJYs6HIZUXiiILpq3iu393mnY4BhQBLfY4dp4pZKsTYVhqA9SYbiXEZcJnmHko/eHITQ/Q0Dvl+9kuvwgKWunIlfckVyWUdDRlaIVq24ZkRxh1Q6pPaahMRPtF4w7CqP6FwyNhiVTkm/sK6Kgav5z2J4n5NHDm0RK5CQiQrfUBm0QHOv2nRNJ7gXlVR/oCZZfx45v6PiLY0j70afs2qR5MyRhsGD5Sbw2PYfoAdj9Fo0cKkYBkw+fNuXwvjKfrUcSYIBHpoeO+A36YXqiLWzp9ou1Fbb1cvyzHtaAjf8FjmpFRKwUPKSYf1WqBhhpI686xdNPPB3jzNZxmuQrOokDrKCWb3yDfdlNk4uqc8aPu8kCkFHHXHFXbjuPy5j14qFB535nytH3Q/pDWVHGgLbrfiHfOnTDQEC96J1g57hRVZ4rXLEejAqkSDyvxP41MhYm/PwK8xr3Oyn/K6PbyUd2vcQWIU3ydU8Ei6JhBwxQLzzXWZ5Oj0TJI14FkkgGTZH01p+DeVjEYUQEDwMHJuIPVK6QMfPzk/KQBuPBEHNS8M+5N6THYm6Zgg46F64ae4saAi6mRkOtLwKeqQhybYiFhRe7P58JFf7+ZoG1OQtU5/lzNHr7bQ//+gw7qSyiXJwPQ9err4aR1ZmuxqgWTynBzZ4Ln8aSGm9eJ1esBGbqOwKxG/y7cO75JJdPfYPXojNJOOzho25uLdR86bZhrlArdIjZskK+KjYNtw86BnbuU1X7kkzrIL5Qn67MpvS7zXBY1/29DOIDc8LMzLIZYq/UClM75LP0KRXT3VaOlcgnrXsCCu72oQu1BiLLgLvMM9SyXJqTrK7jSvawwuoFFhPcpZtsr/q3LNcb3b9WPNkyePysQ4++OTs2h2jo0BUqgRT5MsEfQ=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f389c4-e55e-4196-a011-08db1e31ae03
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 10:58:12.4377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdWFzkuPym9LpP8veQpvU8dxEXOTU+mv3LEoKs7QEoNK3j7aVRL42GxvAG+YxcFSBMwgHRwBPbg1/xhFvp8Uk+mO3H29PYhBnq3DwfgFZ1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0962
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDMuMDMuMjMgMTU6MjEsIGhjaEBpbmZyYWRlYWQub3JnIHdyb3RlOg0KPiBPbiBGcmksIE1h
ciAwMywgMjAyMyBhdCAwNzo0MjowMFBNICswODAwLCBRdSBXZW5ydW8gd3JvdGU6DQo+PiBGcm9t
IG15IHVuZGVyc3RhbmRpbmcsIEhDSCdzIHByb3Bvc2FsIGlzIGEgc3VwZXIgc2V0IG9mIDIpLCBu
b3Qgb25seSBkbyB0aGUNCj4+IG9yZGVyZWQgSU8gdGhpbmcgaW4gdGhlIHNhbWUgd29ya3F1ZXVl
LCBidXQgYWxzbyBhbGwgdGhlIG90aGVyIGVuZGlvIHdvcmtzLA0KPj4gdGh1cyBpZiBkb25lIHBy
b3Blcmx5IGNhbiBlYXNpbHkgaGFuZGxlIGFsbCB0aGUgY29tcGxleCBkZXBlbmRlbmN5Lg0KPiAN
Cj4gSSd2ZSBwdXNoZWQgbXkgY3VycmVudCBXSVAgb3V0LCBzb21lIG9mIHRoZSBjb21taXQgbG9n
cyBhcmVuJ3QgdGhlcmUNCj4geWV0LCBhbmQgaXQgc3RpbGwgZG9lcyBzb21lIHN1cGVyZmxvdXMg
b2ZmbG9hZHMgZm9yIFJBSUQ1IHJlYWRzOg0KPiANCj4gaHR0cDovL2dpdC5pbmZyYWRlYWQub3Jn
L3VzZXJzL2hjaC9taXNjLmdpdC9zaG9ydGxvZy9yZWZzL2hlYWRzL2J0cmZzLWlvX2VuZC13b3Jr
DQo+IA0KDQoNClRoYW5rcywgSSBqdXN0IGhhZCBhIGxvb2sgYXQgaXQgYW5kIGl0IHNlZW1zIGxp
a2UgSSBjYW4gZWFzaWx5IHJlYmFzZSBvbiB0b3ANCmFuZCBpbXBsZW1lbnQgb3B0aW9uIDEuDQoN
CkZvciBvcHRpb24gMiB0aGVyZSBpcyBzdGlsbCBwbHVtYmluZyBuZWVkZWQgYW5kIEknbGwgbG9v
ayBpbnRvIHRoYXQgYXMgd2VsbC4NClNob3VsZG4ndCBiZSB0b28gaGFyZC4NCg==
