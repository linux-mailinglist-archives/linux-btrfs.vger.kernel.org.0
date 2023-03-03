Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E6F6A95DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 12:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjCCLPI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 06:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCLPG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 06:15:06 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151715D89C
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 03:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677842104; x=1709378104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PzmLodUvilLMwNYwxqJN6qAYnaxOUn4R5DmqVTMgsec=;
  b=BDQfFUVdVWXx44bJ3Qsj+HgySBFFbsDuixGp1wY/tY96kEXnj/caPb2A
   +NSNEFv3yEzfaT/j7c8WHt0SQ14nL46ippcoTrFgCgA9BrC/yM6U01cqT
   IFL6IeVQuslJl4k5MCP08+7HZv5nomHR6CNAs9Jh+opnv/W5dau7vbBJO
   xJhHJ8URND8pKURntVvVyx8xaKlZkdMD0iWXY0qkXjiWzZ+UA6VFhtgnh
   4mWGWl20kdUzTqs60kEz3W8xoF2cDkN7vR+f72vis6WL83j9GLRj99LcJ
   e1WmMA17vIyjs1TAWj2JO+8R1kklImO8fY4wssdysFHUR3TnMrfm0i+Bp
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,230,1673884800"; 
   d="scan'208";a="336704379"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2023 19:15:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBYdd2w0N6z5VX2hfzqXfRyyg2YOXoXKCwl2Ev20fYBXeokU0SXW1MqQOj46Qn4T1AU+X51ZvsTs/OqGkl/la82HkSAukZ9pXwOBC5aWOqCmwILzqgFudPZVNp8WToLuNVAim6RDMcLqXH/hbd8dLDnfrA/7o32QSD8iWz22YNP2sYJNcZFOdUW3o3ErJs1JRbX8XBGdybUWyjhObyY3rgixU6O/C6sKnMy9B1J37zgideOgIk+KxFQMsfpmrCSeAjXD4nA7PqxJCsj/Q/65nxUG/2Y/ry/+8JTbTo9oHviG9MvivhiOoEmy1g4dPspMmHKdlBrjzDtJny57A3psPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzmLodUvilLMwNYwxqJN6qAYnaxOUn4R5DmqVTMgsec=;
 b=EntK1F5v3IfT/omMKeTrub42G0g05m1ha+mbysCJExpivix/SUO2/RzMr5e8tRBlrtPujF5a0vrv3J5jAfcoQrevnUmuk8U72XyNWwDYUi+gEeVyMLYV179Jlmphs8gQGvZ+tCQbjuFV6AY26WsFCwZYv1h6yvX+8C09MHXkQXsqfz1Be0dcqeJF67g4EDEczJWwoPgW5784kjJtPvcstj6qgTlC0c9qHwi9BS3PMt8jIFJl0b5qQ2gWfjXTavTd7SGdHMl9cCo7a0xV/uHnd8B8LFI6r3pLTPKRpH6tlD+IiAeK4SrRPDjQ/JCyZ+eQTB5GLIpBMrIcQhhwP3kP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzmLodUvilLMwNYwxqJN6qAYnaxOUn4R5DmqVTMgsec=;
 b=QptPhEw8XBI1nFk4hADFPAOB2nR91N3ZI0bZn+iI1vPLCtTzx2uE4kR47EK0BT4fy0OK9HXFkkMK0SEJgBatcAeZ+V9ewD51A7FoIa2x+iJ5dm8nvmDlFUOE8hzXfBj32/Izm84mq0eNio97EQGnEwb01u4xlyOrGWAR0OY/dhk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8208.namprd04.prod.outlook.com (2603:10b6:408:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Fri, 3 Mar
 2023 11:15:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6156.021; Fri, 3 Mar 2023
 11:15:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZTOvFIu+8wyTHXEOnol2yZkL+G67nUggAgAAHeYCAAAWhAIAAA46AgAAikQCAABkfgIAAdl4AgADUNAA=
Date:   Fri, 3 Mar 2023 11:15:00 +0000
Message-ID: <b538f61d-fda6-2ed0-9a17-216506ab2692@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
 <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
 <ZACsVI3mfprrj4j6@infradead.org>
 <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com>
 <48acd511-7f69-4c42-44ea-a39973d57c98@gmx.com>
In-Reply-To: <48acd511-7f69-4c42-44ea-a39973d57c98@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8208:EE_
x-ms-office365-filtering-correlation-id: cc48e5ab-29df-4dd4-bce5-08db1bd887f0
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CcY3Yu/09eBW06cSFnHLVbPvdyBPiCzXn3Vc7Ehf9TI75NQY2qnOuqbnVcTsO4MyPl1Oix3+iht9c6W0Tz1GRxm7+/s+vTiHU6ARDWA0/HAEPo9o6hxlQgyU1m87fwLvPH9K7atXYOKDSlw/+pW+2e+b8oVogiru4ZZgDdQPF5XKGAlTG/rYTeLXMAJc3h6Z5alMy0ye1n5eOh2KM0dmnKoJnRKd7qF+FeNyMZIAXQ0GvbFxNn0YnxgcG2y51AGeW49BrU7cgbEL1rDQezsUFBLAJKKaOlAqXXXR6m3RytcGuNrB9Tbw7DoIjUO5deP7cBn3HZP7lmd8TXXXzLmSZqJKP73fs2zlJlY3gpq5OoauXp1/rvY/7QyLFNtuNgrOHVjN0fX97ie3RIKYb0xAKY8YxCnXvAU5XG14KRCHJhpuGBYy3eIpbVvUIgCuRppT6cUdOd36EnvKN66n4jhlyW+g7SLreiKEMJO5BvNwawkFJmpYPKpjsab3ISFIF7tP3IYnu83LxgxuV2YZ2807JeM4UYDvFZrEWp75pW5glyPqaJRX2yUOkt25ZKwmvCPkYqEWqmrol4VEjlYjo40susEw4sRGTnlP0C/zxwvunOvls6OWAVds7i6PZCoaR2LP6lW8TX1mgH/3I0xcqpSOKCYVxmoVspMQTSSk+KUdnSYfKIWhXgOucRlQRMlFl+fmZfFv3Z8SrW/BHQvXD0IkFhvT+SQAqlkeSTf4KsF9zh+3IXy767W8EN2V/XNf7IzHDOXM4Od23q6T/R3Yvlbgfn2bw+vzctXsx7b5JfJ7Vcw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199018)(36756003)(6506007)(53546011)(966005)(26005)(6486002)(6512007)(2616005)(186003)(54906003)(110136005)(91956017)(4326008)(41300700001)(316002)(66946007)(8676002)(64756008)(76116006)(66476007)(66556008)(66446008)(2906002)(71200400001)(122000001)(5660300002)(82960400001)(478600001)(8936002)(86362001)(38100700002)(31696002)(38070700005)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDdtelRmNjdwVjRDN1plMkh2MFZMLzFOLzNXcWtSeXptTzczMFZIWUNEem00?=
 =?utf-8?B?ZXhUKzhyS251cm9KalV3WUlVL1hLVmxOdmZrU0pScG5RNDlIK3laMzk0S1BS?=
 =?utf-8?B?OXVCa1llVkQrdUJLODZwcHlMMzdWbXIrZkg1SGhwekpVWXV0cHR1SW9XL0FH?=
 =?utf-8?B?b201ZklNN3NDTFRMelZsM0tYZ3B5RG1CWmhHUzkwK1hXbnRIQ2l5VVhtQWhB?=
 =?utf-8?B?OHBFNTRaaVhrTlQwUmZRNmE2M3hFUTRiL3RsNm9jMFhqY2J5ejloSm1GL0hE?=
 =?utf-8?B?K3FjdStNcXJ0ZWdiVExYaFhibnYzc1hwZUhSWUYzSWZ1UkZDclFaVkRvT1hr?=
 =?utf-8?B?U1phUU42WWNpcDlyYUU4bzF6cVlSaEd2UTFoVzNLTy9IbUQyb3FGQzd5RlJD?=
 =?utf-8?B?cVJPRm1XUXVSaWtRQTRGcVlaV3p6aEM5WEJONUIvTDRjWTVhSm9zWHUvYTNH?=
 =?utf-8?B?TFE0blhiUythSmpVMHY0MUhwNFBMbnJDenZIUFNGUWtWc21CT3F2czFRdjU4?=
 =?utf-8?B?OWNHUHh4a1lZSFhRaDIweitzc3R6SWQvRkduRlJzZy9qSXliVG9ldjYzSVR4?=
 =?utf-8?B?bDZhRk9SMUFHVzROelZNRXJ2UW4vM09wNUpNeW4zUEMvWVBDNjRONGdLeWJy?=
 =?utf-8?B?eXhGbkk2SS9LZmxWTHNKVjJDWDZCeDAvUFVKcmVpYm1HcTVsOXRDSHlwbG9n?=
 =?utf-8?B?eVFHeHd2UXBWWmVaWFAyVW9aa3pmR1NjQ0IwZ1NRbE1pZk8zS1J0bkVYNmFo?=
 =?utf-8?B?cW5waTc1TVNuTk1rRWJrZHZzNFJnaXJqQ3l3eUF1cW0ySkZjSjVCOHQzQ3hj?=
 =?utf-8?B?bXdGbXp1UkFKVURZOENBUE0vbHJXM0o4UHdibnBiNHZZb01yZzhPQkZVSUxa?=
 =?utf-8?B?KzJVaEQ3aThsZXdxQTlNeHVRNkk3VkVMcVVxTnBKdTRXc25la2NqZnB0cWQw?=
 =?utf-8?B?WCtsNXVZNThUNWZJSGIxeG9OaUQxSkVpR01BRU1MZkFHd01PYWhLUHBlbG1t?=
 =?utf-8?B?aWZvckUvYmd5bXZXZGZHdGlxUTZBN0N4QnM4UjNoOXlRU01JeldZVk5DelFT?=
 =?utf-8?B?bTYxY2JjQjFOdU1RN0Q5WEdsc2lIUGpEN3RvSVVsZmxkZ3lXZ1FVbHJCY0Ny?=
 =?utf-8?B?UURHQmduNEtlRlRQUWlmVE5ZbWJzaDlFMUNCc2tqWjdwOXhiOHlUblM5YjdL?=
 =?utf-8?B?Rm5UdFEvaDJRUzZ5WlhZQTFQdGZEZEdpSDdiTW5yZS84YjhiWlRhOUNISy8y?=
 =?utf-8?B?d1k5eVNNdXRXYkZNbmNycWUra1NXSUsrMXVBZDl2dmUrdzVyYVB6UVpoS29h?=
 =?utf-8?B?RHM4N1V1d3hqYmtIenNFZEpuOXlsQk91Smo0blV5KzFTU0Q1THRUdXlCS0kr?=
 =?utf-8?B?dHlVdjVlejhncFdMSXh5U2dIa3lOMmRaa0tOT0Fma1dDYThCRCszRHZMNVpE?=
 =?utf-8?B?bmEzZnZHSWFDVGVnemwvMnVnQmZTSU1LSStkYURERE0zQ0ZGa1dSbGJYSkVZ?=
 =?utf-8?B?cGVIU3k2RzVoa0pmQkxFd1U5Mlk3NjhiY2IwT2FMb0xCRmdLQVdaaCtlTHo3?=
 =?utf-8?B?dklyZVBRYnRvaXNETjAxbUFGSW91akJqQWI3cDFNYWVrYm9LdENWdjNuNzZz?=
 =?utf-8?B?VlFwdFpOQkJzVEt1MlNKdjA2N2RZS3U4R3lUenJPTk80bHcrbjRxcWhhTzhM?=
 =?utf-8?B?aWNJWG53Ymtad3ZUeWNrb3E1d3FvQlpIUFF3Q2U4VjFRYzlVd3YvYjlzTDl6?=
 =?utf-8?B?VjRyQ2VOaHlFd1BCUGNiZ1dQTEU0SUFuN3IwcjVRcitRaTBkQ2xWLzhxNlcr?=
 =?utf-8?B?ZndHSnBsVnc2RmJKVG5FVXdNR0ZSVW9qTC94NVNTNk9WcUlkV0J3SS9RM2kv?=
 =?utf-8?B?UTg3TitrbUlFVmZlUENzMzBrOFMwTmV3UnBmRmU5bjNseHNkSVRoNnFUckwr?=
 =?utf-8?B?bTl3U3dMeEE0NFcrUjVFM1ZnWmlvcnBwd1UwWDVGaEFZWnZRSmFIN3VYTWF3?=
 =?utf-8?B?UmpjbEo5NjI2RkhhK3F3STJaU2dNWHhwN1RkRkdRT3pYcXQ1dUJzNGNzVllZ?=
 =?utf-8?B?OHpybWZ2VW9QcVZyeWYwK0hvYVZJUGRGMUxhenlhdmNBcTdXTXp6b1FobVBk?=
 =?utf-8?B?OEU1cm1UWEw5RWt2TGhsdmR4bjBPcHgxbEl1cXhHMjd2ZlZnbG0zejZ2bERz?=
 =?utf-8?Q?5ZjD+FO/vQvQVTlAEmfwHEU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F537BF77969C824A95779C984D2241C1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CV58mF9fbf1uBSR46K6G5zW9Ljl0avCqzsyRoGta0qcqTqCBhrHo4mSsg3ElI4JLOjgo3dhtGp/G4ftkuQ6sFQtlo7ULZ09sOpS3F2kGhTWKWL/7eyJY2u6eqI5sq6idqWumCITy6xPqjGt7qUnEBN2aAMwRJlRcjSOZT6BUr36A4MyghVQmTlvK+0KKd5NUD8ifB3VJHoHNAtuQNyb7KM+SlOxrUrRDuZUvRwKFp6eRg9U7IZYVD1tcL/trT0qcCJlFC0eWhOl2/Ek+ChxXeqMeu0zQ095FZxCJZbdbH5d5ICoMbAMqpq35ARAmdGYhhFzAEgpXyGwRyFt9EIcE7K344dECQTWOJmniaJIfJEebf4C4FYoG+yh/6ATKoqdQWDcDylygaRpt/d+zzB9w3+6eB1eHbTVfzY7GL0q8gFxHuscCee/qTO/ZLYx03vAYcyo4Pgfqt47QloVSRx5yfqTOtspb4t1PtV8pCFusZIO4X+ziF4NZXI83AEKzV/nOfwQHBYML9+TIDzl69cSCGjcruhvd0EPUszSBj39D2dSeJ7ckhJhwtvfomoCulQmIvRfDu5pr8bOdnVL0le0fRXQeIIXmEioyIn00W1AfuxNCgTBi4XIq8CmEYutfGqiAuIRh7DjPILJJqN4p6UxjPCUDK56O5itfXwSeR6lGs1aFiYkGp58U01bknSXNaYtoQLW9xVhzfrf4mKYbXC1a751NUVsaqUYW9BABMQ0+k+Ojr6xeSUNdQpB0o2MUpKdY2NPFb6QZQGYxR2l0HgS0kGIf1q6FSBJELF7Lr2nArE15ciq7wZMFWvKnWr7NAGfiTSIe6dQDuej2rJaaNnh+W9WS3ic/+jPRdqcR58KEhuAUZdjGJRkwyWWglS7SaoQaH/khVywpooW+yqn2Ze9DXG80Ly1U8DJLNI18mqHfuhQ=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc48e5ab-29df-4dd4-bce5-08db1bd887f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 11:15:01.0019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gg7YvIy9nOEDQhY4oXoH6yc53bBr4ggP/tRUBOD0aemG4nK/scXZvLZzMXuKMheTQ7tWf+p1eoTwpqDa4MI05nQoojghAem9cm1K5N6VJ4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8208
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDIuMDMuMjMgMjM6MzUsIFF1IFdlbnJ1byB3cm90ZToNCj4+DQo+PiBJZiBpdCdzIGFsbCBy
dW5uaW5nIGZyb20gdGhlIHNhbWUgZW5kIEkvTyB3b3JrZXIgdGhlbiB3ZSBjYW4gbWFrZSBzdXJl
DQo+PiB0aGUgcmFjZSBRdSBzdXNwZWN0cyBjYW4gYmUgZWxpbWluYXRlZCwgY2FuJ3Qgd2U/DQo+
IA0KPiBJbiBmYWN0LCB3YWl0aW5nIG90aGVyIHdvcmtxdWV1ZSBpbnNpZGUgb3RoZXIgd29ya3F1
ZXVlIGlzIGFscmVhZHkgYSB3cSANCj4gaGVsbC4uLg0KPiANCj4gSnVzdCBtYWtlIHRoZSBpbi1t
ZW1vcnkgUlNUIHVwZGF0ZSBoYXBwZW4gaW4gZmluaXNoX29yZGVyZWRfaW8oKSBzaG91bGQgDQo+
IGJlIGdvb2QgZW5vdWdoLg0KPiBUaGVuIHdlIGNhbiBrZWVwIHRoZSBSU1QgdHJlZSB1cGRhdGUg
aW4gZGVsYXllZCByZWYuDQoNClRoZXJlJ3MgdHdvIHBvc3NpYmlsaXRpZXMgaG93IHRvIGhhbmRs
ZSBpdDoNCjEpIEhhdmUgYSBjb21tb24gd29ya2ZuIHRoYXQgaGFuZGxlcyBhbGwgdGhlIGNhbGxz
IGluIHRoZSBjb3JyZWN0IG9yZGVyDQoyKSBEbyB0aGUgUlNUIHVwZGF0ZSBpbiBidHJmc19maW5p
c2hfb3JkZXJlZF9pbygpDQoNClRvIG1lIGJvdGggYXJlIHZhbHVhYmxlIG9wdGlvbnMsIHNvIEkg
ZG9uJ3QgY2FyZS4gQm90aCBuZWVkIGEgYml0IG9mDQpwcmVwYXJhdGlvbiB3b3JrIGJlZm9yZSwg
YnV0IHRoYXQncyB0aGUgbmF0dXJlIG9mIHRoZSBiZWFzdC4NCg0KRm9yIDIpIHdlIG5lZWQgYSBw
b2ludGVyIHRvIHRoZSBiaW9jIGluIG9yZGVyZWRfZXh0ZW50LCBzbyB3ZSBuZWVkIHRvDQptYWtl
IHN1cmUgdGhlIGxpZmV0aW1lcyBhcmUgaW4gc3luYy4gT3IgdGhlIG90aGVyIHdheSBhcm91bmQs
IGhhdmUNCm9yZGVyZWRfc3RyaXBlIGhvbGQgZW5vdWdoIGluZm9ybWF0aW9uIGZvciB0aGUgUlNU
IHVwZGF0ZXMgYW5kIHRoZQ0KZW5kX2lvIGhhbmRsZXIgaW5zZXJ0IGl0IGluIHRoZSBvcmRlcmVk
X3N0cmlwZSAodGhhdCBuZWVkcyB0byBiZQ0KcGFzc2VkIGludG8gdGhlIGJpb2Mgb3IgYmJpbyku
DQoNCipJZmYqIEkgaW50ZXJwcmV0IENocmlzdG9waCdzIHByb3Bvc2FsIGluIFsxXSBjb3JyZWN0
bHksIG9wdGlvbnMgMSkgaXMNCmVhc2llciB0byBpbXBsZW1lbnQuDQoNClF1LCBDaHJpc3RvcGgg
YW5kIG90aGVycywgd2hhdCBkbyB5b3UgdGhpbms/DQoNClsxXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1idHJmcy9aQUNzVkkzbWZwcnJqNGo2QGluZnJhZGVhZC5vcmcNCg0K
