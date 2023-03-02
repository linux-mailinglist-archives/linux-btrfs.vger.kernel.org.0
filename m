Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7F86A851F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 16:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCBPaH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 10:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBPaG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 10:30:06 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11834113F1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 07:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677771003; x=1709307003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K9eUJ0gt51/KuBTeWGZYAwoH++9z+SE3Qp0f9KQ/RIQ=;
  b=cTr+9yyzWMx+QGfDgkwFVIwDua1RL2RkfdXyY1WJylSgZzvCIJlHIrue
   2niWJgyPTW85mi+5Tslp2gAIsZumbxDyHAvdjf6Gxl7nIvTZe4ctYhXc7
   oBcM+Lv+JCS1pRAdzoTYUqQn41vEbwU+ZzpLcI9FxMDnjHCwTTAT/ln8I
   sB2R3Mx0gj/vUpkJe/pm6C7q7n28TJiSNpuSFD6H0+z5otNDS5DtTrksR
   /XVNnx1x24Qn/zyf0Q4sWOSei1fxMuXEgqI5XDHLEg86xPljviOnVf0k7
   9HDvBA0GdqI94vKvD4GHZPtOmaTU+x4oNnLIHeMrucrS14TjTXPGnpNKR
   A==;
X-IronPort-AV: E=Sophos;i="5.98,228,1673884800"; 
   d="scan'208";a="328964406"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 23:30:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfAnXEQJnnTHqPOUL/HqtrdcEQxrEqa9e6GH8hHXvGuSLlaZ+oSJme7fDUV349/krabGS8ZTXarLvH5LNaWgnbP1hnCsBzvVVhETEun9w3u4g87amw/0/X5sET6/8SezAhokV2viPLkShWwD6iwRWFqeUfmBiD1tUKalIXY9XYenaDpjw9b8MrxkinYJIAjnYsozporjeeR0n1Co+TjucNiiIMl93+rzNuEkH5+sB2GK5AhDjkKwaYEbTUzyhGXNXGTsxjsunFyrfHdq+g9MYQKItaoJuzv2DqMnfZSxks/UVY/+tbPVUlcnn21sEfNXzCGs/CA01r7TrIJxuETsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9eUJ0gt51/KuBTeWGZYAwoH++9z+SE3Qp0f9KQ/RIQ=;
 b=P48k55z9N54/DLbKq/VU796999sWopdVD1cylvpGBPW1Omeds0651MYS34kYkwprhGubSpWWVRW8lTnQlDNZA6WIsFie5OBsVbrIIrBgSj9Od2ImanCKPTZ00Dj3Y52pk7My4E9o4MnbrKg8jD1/W4brtho8dDzmHZTP8zK1ObcciW90MQM3cfvO86JjM85CkIIY2Y3FPBjtsDezUF4ScVLphkrleekn6C72UY/IA9+aiySGmAVif07lc+YxLam06+zaRmG2xW/AdVyRUSpMG7MLzJMDPJuhVokzZ9vIDfijnkegBFCln9enTvJ4iKxrWLXUYB1jnvUgs/zAuECDmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9eUJ0gt51/KuBTeWGZYAwoH++9z+SE3Qp0f9KQ/RIQ=;
 b=QQO4XOu36UOrhepza4OceLFIuH+OV0B+5Xf5h1yfeXJsct/jjU8Dlna5p5SNRFo5HHClCe7f2FR8Vaakw05eisZNsSRSMAv4TsXqfU5nubfgTs1sLKUs1F2AoEyRwjRZXzMujwnVA7kVbvcoNpeD9KvPEyH1XW5DnyEgAiMvz/s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5260.namprd04.prod.outlook.com (2603:10b6:5:105::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 2 Mar
 2023 15:29:59 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 15:29:59 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZTOvFIu+8wyTHXEOnol2yZkL+G67nUggAgAAHeYCAACsfgIAAGTkA
Date:   Thu, 2 Mar 2023 15:29:59 +0000
Message-ID: <f6e46baf-8c0c-9925-63c1-de39f42e9adb@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <ZACrzUh82/9HPDV2@infradead.org>
In-Reply-To: <ZACrzUh82/9HPDV2@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5260:EE_
x-ms-office365-filtering-correlation-id: f856890f-64c2-4b70-aa0f-08db1b32fbf1
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YCJe4SuesmHim5nBnThLCWClsW0axAyjePH4G68shvW4T8zZK2lrB66as5JbXiLqvT+Z81GNk2xf2YmLQZ622Jsl/+lyPaMatFa9Eag1IiR3bfTJIxui9iPUy91hnFGzvmY3+DKdc2ctg4ZiBSsV8k56havLe61vf8aEOa8dZ3jlsi7jUEPXp9ihWeYvEN9ngrtfmOibit2hvbp58Z6sDOEcKtM51H4Xihe8rtIMO9npM5yDB20QCTVxjHoGippBKmXMq3prcaiUr9pEGsP5Ky4LcmDjwPMD2E8i2RwSaXHnJ8uoZvq7tCTUr14a26VfldYpvGlyNRZZAIXx6dpIII60NaaTRgU+1vefp5EE7gqKp791791TrnHT0VEyuUXtDSkpCFYFTFjYFXxqL1CE7iMeFpbciJXKowsgvHb4OYEIxec06u7LFlA4regAyN6LiB+HnooaReq3MyjW2yJqHoKoAU/q0DPcm6V0tpC0FUCZZAcZmEWvPlizu1oZJbnKHcVHSg+ltr/GhuulHG27T/6zfPivLbZVswsqvqadRaS6d/lJ65NsDKQcT7zNMpFeq0q+1m89rU0Z2TZwpWOoYqIy0lTlKUaBqOTs8VDq7rP/6YypkG6yu/M685moa+vvv7ugDFi9mVhk5OMLDNZf3FFiVFZzcHmnSf+j/8lHLXdPjawPOQmRMcWBYxuzh+N2tmidJ14jqiwO6KI+XfnrczKT2msZpdGu1Gr00f7nDZrhLvBPAvnFb4xmwYaoU1FGcb2DBCjYk2S+XZgDzvTV7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199018)(31686004)(66899018)(71200400001)(41300700001)(2616005)(76116006)(2906002)(83380400001)(478600001)(8676002)(38070700005)(186003)(6512007)(53546011)(31696002)(316002)(26005)(6916009)(86362001)(82960400001)(6506007)(6486002)(5660300002)(91956017)(66556008)(66476007)(122000001)(8936002)(66446008)(36756003)(66946007)(54906003)(38100700002)(4326008)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0ZIMGtmUDVVQmhIaXVuUjR3dFVzQ2pWOXExMVY2YnREd0xOZDVIQnpJYkw5?=
 =?utf-8?B?QnkxeVd6TlVsSnB1aHFaRVl6ZE0wWWFyV2dXWlpSWENJRndXOENuZXdiTnVB?=
 =?utf-8?B?Z3pibkxtTldoR0xiOXVwQ1pUYUtPN0ZteWI5eE1GTVIrMWhKcDAweDBrWTFo?=
 =?utf-8?B?aXRScHpmR0d2aDRGelFvQlo0dmE4ZVhxbGxINllDb0ZBdkxVU2Z3blVReElx?=
 =?utf-8?B?bzBoYVB3QVo1OUlHdUNVTG9JcmVrZ0NROFgrY0FnZ0lGVU9Ob21WN0lLSk8y?=
 =?utf-8?B?MHNFeUllanptNFNSUUxrS05ncVN6VEJQTENYeExIcE9aU0ZiSFY5RlM2ZFJ3?=
 =?utf-8?B?emQ5Z0ltdVgvdXVEU2xyVFpSK0p2cERidWZvQWVMQUJLcUNNNnJoa3p0cXJC?=
 =?utf-8?B?dU90T1dJdTVVbUwxMlRSQnA1cXBEeWxTazB4dzg1TXR0YWR1VytQZEppUGx2?=
 =?utf-8?B?ZTEzN0t3LzN1QXd4akNjZXUyak5WdHJ4dTlySVVtMXdIUXdjVld2SmJHUFRQ?=
 =?utf-8?B?Q0VPMVBFaURJVVAyR1prZ0NQeThDVEhNbEV4cU5oMzVSSXNvaXlqL2JPc0ZG?=
 =?utf-8?B?WjB6ZnhQcVVRMnd2bzlKVzRVSkhqUXJyN3doR04xTUJXYzhvYitia3pkdnUx?=
 =?utf-8?B?T3ExQkpaMjFWSmNYMzZHL1RnTGZXQXZRc3VmT0x6WTRaTW54cXhzaU9tL0ho?=
 =?utf-8?B?WHBwaGg3akE5ZmRUYjFZcFd2QldnNHhNejhwTTYwczNOSXY0OEJMV2xTL0Nv?=
 =?utf-8?B?ZjZ2b05ndkpOeUdqMURiRFZER3pQdGd5eUpKWEcyUU84UTM2S3NVSmlGYk9y?=
 =?utf-8?B?bUcrKzNXNy8zUWJORXltMEhkNnNaQjR6Q09sVEg0WFRPRGhreUI2aHhUSlpa?=
 =?utf-8?B?d1AxNGo4RklOTVErK2Q5Z1Nsb2JVd042RzFpNXd3Y01GUmZvQmtzcThCa3h0?=
 =?utf-8?B?eHY4SndGbVNmTXBTMVpzS3dRSmJJSHNRak41bWx3MU5UY2Z5c20zRllqWHJh?=
 =?utf-8?B?NEFtWm11ckRZOHFXdHdSWld6TjNuYU5aV3ZPcTZIRkg3YUQ0aWVYdW1oZGlC?=
 =?utf-8?B?VWtSZktQUk1UNE9OS0Q0V2w2YWE5NG9ScEw1UzA5Yy9FeVVxVVdhSGYyR3Bl?=
 =?utf-8?B?aXpLWUgxU2JQSENJckNmSXBpbXhMVlBLeGNFZ3pMZk9jUzc4bjhKVHRSS1RI?=
 =?utf-8?B?V2hvWlpEdmpZMHdia3dRTGNuUjBVS3o1c3hTdjNJV0F6ZllBcVVscVdPc3Bs?=
 =?utf-8?B?WVR6aVFVS1FGUFRKWWMvWHFoajd1N2xGZmY4VzJLeHFwR1p1bWpQeC9mUGpa?=
 =?utf-8?B?a3doVVlWTFNmOGZnaXozakpwNmdoTGJrNkVnamVyMzM1aGRYSHNYZDhVOElU?=
 =?utf-8?B?blloNjVKYWJQc1Z0KzdmZCtvaXZnZHlvRTQzMkg0Nnk3M2lyZmwvV01FMHVR?=
 =?utf-8?B?S2tiWm5hTGVTdWtjRG5xeWllY1VEQ2NRUjl1b1FhbXhKRDdveHovMlQvZ1Ez?=
 =?utf-8?B?eW5mSC81dDN2RkFZTDJjcGRUTlZILy9IbTJkYmVUbDdmM2k5TVBJcnFIV1pQ?=
 =?utf-8?B?RTl6SS9JR1orL0N3cDBTRXJOQU83MTU0TVFEbmJtRWl1V2tlRThFNTZiTC9V?=
 =?utf-8?B?OHZsRkwvK3Bxbkhmb25TcUgyMUpZb2Ryb3ByemZZTDNkNEc1MkVyNFhYaFZT?=
 =?utf-8?B?YWFWUDRsK2srcGo1SWtTRU5yZ2FudVJqVDZFb1d2OFNDcnA1SXd1b0VTNHVC?=
 =?utf-8?B?Z3M0RUhjZHRZK2svdFFWazVqbkhwV1hQTmVYUFU0c1V6c2JFKzIrS2tVVm5v?=
 =?utf-8?B?WmV6emt2ZG9ReW85MUpTSFF5V3diSkJYejcyTHFxazc4bDJtTW5nSnVnYlc0?=
 =?utf-8?B?dHhiRzA4NjMxQ0Q5YVhwNEJlcC90Y3VOc3pTVlIrRmVuUTcxTkhlNEJwVU1Z?=
 =?utf-8?B?YTdqd2twT1RoWDZnTGl1N0ZrOVlRK1VGWi9yZ0ZnQmU4RU9JRVhPMlpIakJP?=
 =?utf-8?B?ZHp6Ly9iS3A4bkZOdVQvOTA5LzF1bGc3TFFORENLUkcvdlNPSUo3dlZzQzVP?=
 =?utf-8?B?WHVUam91WWlMbUczakgwT2RHQ2JSQTFmb3JnT1h5cmhkMnpEQ3I0Mm9tdmNL?=
 =?utf-8?B?Um91TURvMlh4aWNRbnRYMm0ySGNTOHNDWFlYZE1SeTBDTFljcG90MnI4bkdp?=
 =?utf-8?Q?iUxLTmZa/8IqUHH5yHsuJ98=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63500590F5955942AFAE6BECCF4A2789@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ogt5+RRYL8GBr+HSSEVYEtNZgL8epFWFv/BfAOp5YU9SwXKdmKE5ZQn5Pt4oMpIW+hLqgWc3hVM++DpDjQr1CxXayn8/X44ed3ghuDt7E4ZHUuqAh6+M66JR/cuirQjX+hHsqy9zMu5IZla13powMP/VcxLs9h+J71vIywp7V9GJEchTXiarP4hirGwoiGF0ydSccXSLyqPiDbznhwfVtJL9ambuz0O+8A501TNnhuMLrhsTSdeDowNPd0A4ikYL2LDwo38D1UeRE34KCpmRGUgnSeIMaZxJk24OVehVdbuNO7lpgGvZtZwX4cYtliU5slyNPt2Wt5bb9D9k15DLg+XaF7Db8BjuFc7JwERNvIHKY4dTYt3z5xr2cMy/3JvvUX+LJ8m+T1MSe/DqdUDvP6A5Fl8xY3O93rjNgkVEmgLlUvUPrtpwXK0VgK3dq2zsTJKLVUWEb/aAq+A+eqFxF/fVDA1IqPWOmyfN8NPKBnmib8M7GTwquqav3E/uI8L6lE+FTcuPPKAowQK763iA8a/ADilKc0rXSw3y0vVd9EszQskdkxvO0L93noUgo3/1tprFqNanVUy1hiiS+7XQKJuyGP6EOfUhDWecdl0yfPEsUwA8P9LiMCxOIhiQ9heGjCsvUIqXf6htxpcLrB8a2A6ET260VZFfzsGA7cJbvbcEUUTQkFAVXK5kDhYfnjPrwzQcAhL9OwHnRMTx7gG7pxFSBDGfKIm1uEpgR4HYGYqcc5jGyYlEjA8Qc0P1sSJxbKPSPbOfSaUYwsXtrXu6sjC0i3SbsgEOuedRG9A3WTrXMkNDcHPod5sUwSk0YdADxL3mFOU0xxX3USehnno4FG1P1iw/avGeAdDbYU+uCtydKUVDBbutoYhOmr03mOn3uTLMIbFuULFUKbAVk0ngIvOxkFMw9TqK0vntJi6trF0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f856890f-64c2-4b70-aa0f-08db1b32fbf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 15:29:59.1978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QfchTpLukcOvKi4oVI7CRjcyNHgiyKqvnWKevyc0HRA7ntBY0w0JjU1rLbC8w5DEt+FxO0zbnGfEDt61VIIslkp/uJUw4WmKPP64cBhYhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5260
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDIuMDMuMjMgMTQ6NTksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUaHUsIE1h
ciAwMiwgMjAyMyBhdCAxMToyNToyMkFNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+Pj4gVGhlIG1haW4gY29uY2VybiBtYXkgYmUgdGhlIGJpb2MgPC0+IG9yZGVyZWQgZXh0ZW50
IG1hcHBpbmcsIGJ1dCBJSVJDIA0KPj4+IGZvciB6b25lZCBtb2RlIG9uZSBiaW9jIGlzIG9uZSBv
cmRlcmVkIGV4dGVudCwgdGh1cyB0aGlzIHNob3VsZG4ndCBiZSBhIA0KPj4+IHN1cGVyIGJpZyBk
ZWFsPw0KPj4NCj4+IFllcCwgYnV0IEkgd2FudCB0byBiZSBhYmxlIHRvIHVzZSBSU1QgZm9yIG5v
bi16b25lZCBkZXZpY2VzIGFzIHdlbGwNCj4+IHRvIGF0dGFjayB0aGUgUkFJRDU2IHByb2JsZW1z
IGFuZCBhZGQgZXJhc3VyZSBjb2RpbmcgUkFJRC4NCj4gDQo+IEkgaGF2ZSBhIHNlcmllcyBpbiBt
eSBxdWV1ZSB0aGUgbGltaXRzIGV2ZXJ5IGJ0cmZzX2JpbyAoYW5kIHRodXMgYmlvYykNCj4gdG8g
YSBzaW5nbGUgb3JkZXJlZF9leHRlbnQuICBUaGUgYmlvIHNwYW5uaW5nIG9yZGVyZWRfZXh0ZW50
cyBpcyBhIHZlcnkNCj4gc3RyYW5nZSBjb3JuZXIgY2FzZSB0aGF0IHJhcmVseSBoYXBwZW5zIGJ1
dCBjYXVzZXMgYSBsb3Qgb2YgcHJvYmxlbXMuDQo+IFdpdGggdGhhdCBzZXJpZXMgd2UnbGwgYWxz
byBnYWluIGEgcG9pbnRlciB0byB0aGUgb3JkZXJlZF9leHRlbnQgZnJvbQ0KPiB0aGUgYnRyZnNf
YmlvLCB3aGljaCB3aWxsIHJlbW92ZSBhbGwgdGhlIG9yZGVyZWRfZXh0ZW50IGxvb2t1cHMgZnJv
bQ0KPiB0aGUgZmFzdCBwYXRoLg0KPg0KPiBTbyBJIHRoaW5rIHlvdSBjYW4gcmV3b3JrIHlvdXIg
c2VyaWVzIHRvIGFsc28gbGltaXQgdGhlIGJpbyB0byBhIHNpbmdsZQ0KPiBvcmRlcmVkIGV4dGVu
dCwgYW5kIGlmIG5lZWRlZCBzcGxpdCB0aGUgb3JkZXJlZCBleHRlbnQgZm9yIGFueXRoaW5nIHRo
YXQNCj4gdXNlcyB0aGUgcmFpZCBzdHJpcGUgdHJlZSBhbmQgd2UnbGwgbmljZWx5IGNvbnZlcmdl
IHRoZXJlLg0KPiANCg0KVGhhdCBkb2VzIGluZGVlZCBzb3VuZCBsaWtlIGEgZ29vZCBpZGVhIHRv
IG1lLg0K
