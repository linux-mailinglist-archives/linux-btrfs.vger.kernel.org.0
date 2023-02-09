Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68D169026E
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 09:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjBIIsF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 03:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBIIsE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 03:48:04 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4096F11EB3
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 00:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675932483; x=1707468483;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=mp9KYbs+I9vjmG95ryf/hgkGdftMaqxx4/zIibOcLvk=;
  b=P3+hgM35zYy2PADhor22oB9/KhI0INlHA8QCRecbG2iuZSzgcCsg/uT3
   +KwJ1IBa562w/WHzigaxB6Vtz8KMOW2hfMt2/TNgIcD9/zLk/nV8w9CxM
   zq1F77/8ThESmLEFXO1P2lHcyDC3MO8KrL88QOVU1EF3Wh+b0i0OLlqAc
   Dwhs9hx3HjscdqVxvXxyJ71HHfVaTh0ELg9wJE1vbM8Jye0d+VVPLVS8B
   QhWJX85Ff7YHcE47CzQkB40JMiAFh/DiM2HJqxSZZrOgoMyMM9MbtZ7tT
   uzUx96DZ/u68v64rD09tocdkWpXZTywM4QGXID4jIUH0VHOgei2aLHIM2
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,283,1669046400"; 
   d="scan'208";a="222689136"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2023 16:48:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAxn92775E8IRFizuxhqSiJ9Kx6rCLggm4KUinu1EsNw28DX1/PEIxCBeBDWi71vtnNnwlifqGAIyUfLnNQhfAyMIZhQ8CqZ23bGxzpOY6CocUZJOx+NsSCj5B042aTtregW8Sl1Y4UL1LeHBxzmMIu7fA9tUjnqwnukrbvLfLu4IJ+4MgHxTuXzIJNGiMv9yKoUbwtPIMDpb9vJTMTmi9czSg085E6ZsuiABCgf6POZVEcH+tu0EcTpbKD4fTGYeeAprUDlyi94+2l4cGI/GvDuQRC/Clno6sBmYi2/uum4tBnLJaZxcWuiCupeXsoz2mrSe0e3uiP6hrJKZyXq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp9KYbs+I9vjmG95ryf/hgkGdftMaqxx4/zIibOcLvk=;
 b=kqdOMz6Iq6o9/DWqjdivXhANegotaMlCwX7wTP55o2sMhbjNuAHc17St7KFJ4iku6Iqh27F08q+IYHFelQtLUiGupy2aEtW5KXjgQbhJcgOBM/x1E+14rZAI9AYTiUgBHTxGD2o3S0IXPC0LUVNBCcBeQGVFl9wLLLAezpMGjlteFd30QG/ZY4ZuiM/UPVCsH5OQJx6KYOtzGwhlHtUKv6Ji56r14WdsI1LD1R+TfAgOtpXp1ibNIxoK36b63FkW9VwMwtZjrX8IRrayJo0LKRAN5m1jlPYbdwFTcqgtsALdrfeFfedZeb+wBQRUNpw7LiRkFUS9pPoKE0qcGgQWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp9KYbs+I9vjmG95ryf/hgkGdftMaqxx4/zIibOcLvk=;
 b=rZh02SJEfnzcfQN5lYIrJ6yJLpjSewO/Yls2+jSswuSGzFF4EE5hv/OjZg9wAiK6y5dnhVCoUo0yPyLwQgZDHN2uR0alHR0WxZcAByLt/6LwzvWP1VWpuYAHj+ZNvhINddrSpB5utKY6BmXyIyGqSU/GdBQ9dN/6ApHURs0CUZk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6540.namprd04.prod.outlook.com (2603:10b6:610:64::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 08:47:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 08:47:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 00/13] btrfs: introduce RAID stripe tree
Thread-Topic: [PATCH v5 00/13] btrfs: introduce RAID stripe tree
Thread-Index: AQHZO6w01UFWKaz32kSJ4ybjKHGu4q7Fx3KAgACHmoA=
Date:   Thu, 9 Feb 2023 08:47:54 +0000
Message-ID: <c72435fd-709f-2027-e509-dba4cd2a5bdc@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <c2c63ed0-d987-1165-d1ff-e8a3020fbac7@gmx.com>
In-Reply-To: <c2c63ed0-d987-1165-d1ff-e8a3020fbac7@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6540:EE_
x-ms-office365-filtering-correlation-id: d78dda9e-d096-4227-4f3b-08db0a7a5595
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rHPJ6WfXTO410oXpsg6+erfxF60A82FAVhgIpgS+CK9Y/YUhkXBcIP7v8fS5OgQhbPqXZx1GNpPhdF/gm0OCjBc5EFE6yg5K4Rx0zVdgaL+ORc+jv1E4wF6oughts21X8ilEMNUHzq7eKlZ20zrJrXAc6Z5YcAkU613+Oz+qymgD6NrEKaZx0trSYPER9IsVezzAdI2TbsIWzUeGt35vOARFoQeOhIgkCRTFStritxaIbtj49/6PquIUe2Fjk1+Ljno54+SFoNPzeGUMzJ5v3Qfm0k1H68WTg4NlmUmhzGNDLcM5/VFFXLPzhUUo5dCvGl3BtrhMGHnj1v4FA78NjlQMybEQcsPMwENYVTbWNVnDlN3B0/68AR397GQPvkrWYNwISZ6u6T+hxsIm/aJ6bjquh2aC2w1ZrGT81dpHvX0zWQK3j8hpqs3pSFH2HH+bJVOllucz3RaYgFR15QCksgRzI7oUPJoY0CX7VuSdcZKy3dkkMAfAAGbBJxeKc2S/dqNkUqMh8a6G19K/B5oPBr6/c2W2HQZk368B5EVASORkUgMk/EibsF3ucaAfFcBFZ9ICwwcZLhCUpZYGOnaG6shZQJbgtZ5zxBvpm/dVQCkyUrkwS+R07qI5AUh1EQPCxuX5mPO3LLWm71ae+qRBeRqXfdVbzWcwvpv42LTqPPKJTtazi6S9S41EAUCFeQQaNJz6wBdSLVma+UaEfa8vWsOmfq/RuZ/wUTtVoOrQp2u6Da6K624Z0uYsbmjg8iVQJ3RU9WpfwURN/X2f19lhNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199018)(38100700002)(82960400001)(36756003)(31696002)(41300700001)(71200400001)(38070700005)(122000001)(31686004)(86362001)(5660300002)(2906002)(2616005)(4744005)(8936002)(110136005)(6506007)(6512007)(53546011)(186003)(478600001)(316002)(76116006)(64756008)(66446008)(66476007)(66556008)(8676002)(66946007)(91956017)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVZMY0VWK0RLa2J6SWY0WUUxWVVWUER6T0IzOEpnMldCOWJ3R2pBMGdoa0Mr?=
 =?utf-8?B?d24rUzhHNmNOUVZuclNhQ1ZOSWJvcUdqcUhkaFlRSEFXTDQwZnQwNmV0NENN?=
 =?utf-8?B?QzljbFVvQnZhbWhDaUhPTHRKdDNjcTJNZlpCVEw3akoxTjFaZEJpdEdRZWdR?=
 =?utf-8?B?Ykh0cVJYZWFsbDlLbVg0TkJhck14bDJVQTBaY0hZZXF1VVcxaDJ4eEdtYU56?=
 =?utf-8?B?anhCbFVsSytleFdRcDU3Sk5mUjlkNFgrcW9Pd1crWU5ROXFHVzhPYjJIU3g4?=
 =?utf-8?B?VVArQjV1M3dEQStxWkhheWcxRFgxSGJhZXdsN1M2SW11YmpEd1M0a2QrOEJZ?=
 =?utf-8?B?YjF0eGt0Y0Q5eG02S21Rdkd6bkVySlR6dEZaaklaRWhEUVBPeGs3QXQvN0ZO?=
 =?utf-8?B?QVZYSVc5c3F4ZGpNek5aK21FNENCZEwybnRrQjRuN3hqck5HMnE1MW1wZERs?=
 =?utf-8?B?bVhEUHJmbXFnVjBGVGNidWNwODhRZFp1T2ZXdU5NdXMyY1BseEd3RzlzVjl2?=
 =?utf-8?B?YjUvWlRDTWoveDNaMmZ5SzFDY3B6bUo4ZExsVFAwaDd5MzlWRDQvTFJDUkFa?=
 =?utf-8?B?bllsT09uR0hOZWNQMFh6amRSeTVMbGhkSlVXWk5VdjJtd3ZpdTc5TDRZdGMx?=
 =?utf-8?B?K2g0YVRPTHBweWFPM2h3WkVlcXpENWNhUUZobnFKS2ozbFhKVlVheHpxbXAr?=
 =?utf-8?B?NGQxMEt0b0JkL0dIcEhibXRFTXVlcWVlekp4cjFuNmU0N3UwQWl4d2Q2MnND?=
 =?utf-8?B?QU5KQUVQWUlpMzk5aWExVUx0TzdrSmdIQlJQOU4xT0d2MXNobXhKTFNvZHRJ?=
 =?utf-8?B?MTVGWVEwalZFMFp6OERRaVE4enEzckxEbzBvVzVYZ0JvQ2NCM0llbCtFMWhi?=
 =?utf-8?B?SWVlSXpBVmU2Z0xtaUJzRnJ2REExY2ExaGVaMk9Kdmk0M0pGcjZhRE5WL0NG?=
 =?utf-8?B?a051ZEJzK3hyeUxmQ2IxSEJsV1k4VWdDZkViYURNTmJrYnl1clN6QVh3bmlq?=
 =?utf-8?B?OWlBaWNYeHRmb3FpaENIOTVmYjNmelVoL1pXL0NhTnlpcHhqb0lYWElnTlMy?=
 =?utf-8?B?OGZZbWxBMlc2SW96ZTU0MHlrTFBvVGFEYWVhc2Q0L2FSMEpUU2Vpbk9TTVVl?=
 =?utf-8?B?bGtuZHVhdEpnVk1KZmpHVUtMV3NOeVJGUUVLN0VGODFCRjh3NHpiZDYvUVFP?=
 =?utf-8?B?YmpJUUdtTC8yaDBwajFnMFd3RjRITmNyYnJUYTVxWXh0NWpBeFBLVUF4Tkpu?=
 =?utf-8?B?bmNLZTFGL242TmNpYldQM1lUaEpMc0d2UVJqUWdmMnZ5MXZmcExvZFdBTHhn?=
 =?utf-8?B?VzJjQXhKQ3BBd215UFZtdXBHVkczb3VmeUlPSVl3RGppVm5idmRSRHUyUS9S?=
 =?utf-8?B?dXJRb0s0bTEzSDhmeHRPQkx5Yjc1bGVwNlRhNXNkOHcra3F2clh3Y2lyM3Ja?=
 =?utf-8?B?Z0daTCtJYWhZcVA5UUJjbElJSURxV1c1UVBiOHhVRHhwemRuNkVNNE5nRk5Y?=
 =?utf-8?B?RHIyMnF6OGpyODNxbWJ6d1lqS2JKK0FDb0l0OVV0dlBZTGpPRGdMOTFUU0ln?=
 =?utf-8?B?aFFnWEcrYUpNMFpwZERIRUVFZnZaWUJaa2FoSng1MUNveWJPVXJwOG9BY2dt?=
 =?utf-8?B?T1JnakplYTVNckFScjg3YlZsZFUzaDAvQ1ZYMkNycUpXaDBXN3ZUMmNiaHRx?=
 =?utf-8?B?Qkt0TER2S3lUa1VwWUR4Wk5EaGNpb0JyWjY3dlhIMVZ0bEM2SmVYZlVYeTdC?=
 =?utf-8?B?SmJ5VndlZFBOZDl4UXYwL1l4TGVGYWo0OTQ1dVB1Vm42NTVIWlJqSmVIOTk1?=
 =?utf-8?B?enE5eEhhbWsweHY5NmVpNzN2ajhLdU9xSFN3V0ZUWWtVZ29YYUdyZTByMURh?=
 =?utf-8?B?cjJiYWZIWVJSQW0wODVxSG04Vlo0YSswMG02d25qZUEwVDZ4ZDI5MDNhclBX?=
 =?utf-8?B?cmhrZUIxMC9MaytWR2p0Q0k4c01SWGc4MmU2N0xCdTdGTENSbGxqZDJlODdE?=
 =?utf-8?B?RzJ5eHZpVVlhVFVOMGpoYjFKSVRSUExlVUVLNEpxYk1BdU9HS2tFcUU5L2Fq?=
 =?utf-8?B?U1dEd2ZxdW5tRUo3cXp0WWlHWmQvb1NPQTQ0TlRxYVN2YVhCbW11N3U1Tmty?=
 =?utf-8?B?eUxkZytzazJzbEJuOUkzNDRZS0Eveit1NWhkSCs0UDM1azJxeDBiZFVDckY5?=
 =?utf-8?B?TXpKOVBtYjg1UGN2ekd5KytDUzVMdnpFSGRSUzBwVWlOajVsUk5GeFJ4WnRl?=
 =?utf-8?Q?jldYnZtRGmSs6T0IPTgTRcXY5jJ8nA6vDRZ7SAOCIk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BED295FCF40BEF468BA1B1BBA7FAB00C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6iiZDFIo7Ao6+21Bq7EIOB/G7SVntL9dYIrjvt8Bv2ST4ilKn6RAhSouYhmq45Ym8WHVzcB1ARJULoOVtIKudRVTKPIUIh7/BW2dzZDgkkp1tYOdjt0JJB+aeX1z09wQQErawwtyLk8aDA5EhP15Q93rBgFexffCrb8jIwhbD8t55sHAjW3ax8UAA2RRVLIj3vDZD8KPL27VjUQVTKhW47SCQV+dZH6kSNBK302xqoyb7MYXqdowk62GzL76KsVbKRyd0nDg8q8vJ+W7zZmcoHauUFRArACfQIvOcPoh69newDwhGyzn6c2h3Q8xu0j5KwU2+tedq+AerDb78zbM7muc3y+J+OvID5eS4j5h5GGubBGL+QQzuKq3/MeOuSySRVkpJG4mmw2WkYh6y+ff2Gd4GqHnpqCoaXd14UK1SpBYMx0raEwIxadZWR5+MuCNl7vrM8MU0px/RJ+X6kupWi/9TCFYJ8FxATPRWa/u7hS4bVkkgea61ZHvszI9qvB/+uiN4H/4fb/9o0fVFz16eJrZfRJmMB89xKkCGN6DlAJZoEnvtlk0VzlZhTbJRNO3cdI4nZMiz5HIP8fbaIBbge6QyQ9RIgLq6mh0BAGVtz5ZTxcqhm+L1xDrIN90RJ3wvek209DDpaLikjSpr5bsIz5vy1vEoaIpXEwdZ1Kz10U2g7v5E5Rmhkk3d9thUKxdju5WcAVMrOCpNHmqE9gjfyDqI3otbJH66/tXi+9YX7ez6loMoWUZDwA2xAz7dF7JQMcm/cxWzg7jgMxVyNOpoCRoMq7WwWAyYZ1fF0YSZi0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78dda9e-d096-4227-4f3b-08db0a7a5595
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 08:47:54.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6YOElHews/vx/n5NMrniruONyJ/bRGL/S5561Gq6NYmn4XFYajj141Kiejz+6Xv6qpGFAMSCk/zXcJEQgxb3z3e5sUt22nUlt+6nWgOLz74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6540
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDkuMDIuMjMgMDE6NDIsIFF1IFdlbnJ1byB3cm90ZToNCj4gQ29uc2lkZXJpbmcgd2UgYWxy
ZWFkeSBoYXZlIHRoZSBsZW5ndGggYXMgdGhlIGtleSBvZmZzZXQsIGNhbiB3ZSBtZXJnZSANCj4g
Y29udGludW91cyBlbnRyaWVzPw0KPiANCj4gSSdtIHByZXR0eSBzdXJlIGlmIHdlIGdvIHRoaXMg
cGF0aCwgdGhlIHJzdCB0cmVlIGl0c2VsZiBjYW4gYmUgdG9vIA0KPiBsYXJnZSwgYW5kIGl0J3Mg
YmV0dGVyIHdlIGNvbnNpZGVyIHRoaXMgYmVmb3JlIGl0J3MgdG9vIHByb2JsZW1hdGljLg0KDQpZ
ZXMgdGhpcyBpcyBzb21ldGhpbmcgSSB3YXMgY29uc2lkZXJpbmcgdG8gZG8gYXMgYSAzcmQgKG9y
IDR0aCkgc3RlcCwNCm9uY2UgdGhlIGJhc2ljcyBhcmUgbGFuZGVkLg0KDQpJdCBjYW4gYmUgZWFz
aWx5IGRvbmUgYWZ0ZXJ3YXJkcyB3aXRob3V0IGJyZWFraW5nIGFueSBldmVudHVhbCANCmV4aXN0
aW5nIGluc3RhbGxhdGlvbnMuDQo=
