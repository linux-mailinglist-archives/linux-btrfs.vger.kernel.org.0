Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984886B90A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 11:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCNKwy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 06:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCNKwx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 06:52:53 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26B16284D
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678791136; x=1710327136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=YRxuM128gJxNgiFP2PQln3ns0eXJeX6xHUdfjUqxObI0NBsg6Ib3J9rF
   X/lI2x0xWk3ewaHaJUd0z/vmno2dfTONZozlC4m2ZXNn4zoONhkusnjuz
   WtQGVLDGDf13CvaAfEAhZEBF++PCGlU3WcuRvE/PyEEta7Od4Mo/H5ruS
   c+yUTxBHmm7jVeUFpuhEfsPUG/rQgUufD2BDtZNH7yXmvd1yP6bVGodK/
   Ehb7na71cnhWltVq5qPnW75HPJVCVDYUXjHKJdMIUeLw5DkQdlEVbTO1B
   Q1W7fV3RZ18RaId5M1L0kdOfix/smyOukwNueNcQlxaZ94aKSgG+bpLMJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,259,1673884800"; 
   d="scan'208";a="223874548"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2023 18:51:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmz3DKblIkjOpRhV/kNjrlMWhLnjT1lHpIYbEgEZpc6DZK+kVsuuU75Q0TnOidIvjNg94NK2Tl0LHQGyWTPkR/h6nGULZbYlQIVhhLOQnXNku0H8wT+EicmbRYGdRK3I72afFY6GVpsqB06LojIyLoOEk075wvxLI+c3SwHpo1oD7ccvX7emnmeLMF/kNa7e+J8d26/20zNRMAYXhGAv7zbWg7X4/PfbHMZ4FdjayHglo0UEReKcUoAybOBRZX+B4UpjU7Cj8zhAzKMUvNRPYXNiPzwlNabC9a6q3eGoa4S4MJ1QHIQkTTD+CgFVQHwMKST6C0XIf7KJLI25PF4svQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fArGzcfqx1UQB0bLcLr4kGvGds3klycH2i6dLTv+bQL3ycbqf9xzYYd5VBNbdDPu3Miw5uUWz/MFasoeA4ehD5w6GsNTF78PQP9EGOGyhzqyvQk90YmqfSE+9SqEwj9R38MWbVjwUCv4Wd0K80LHzsDt483D7WvdvVD1w/eiY+9mUCcivlTRurdRTWeRHkbkjrNMtjtgV25cH549784/VlVO91+LutqWVqOBiEHP/VJMNZiH/fyI5to1X5q6XR3W8x/16TkCqigtzH1W34MPaUJL094SO0VGJZ7wX1WI9IpYE/owsa5W9h5dO0xgiodpo098qAUR1P7MapkwCiPhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=UEV8UFgYck+AS5BXheJRdHU8cvp4wc9GyUK0Q/LFXjipOfdq+mtBDLqU3yXFS+ojhQWgoCUhYaD0fpBoy12CvPTICIWtmAAbmWBytG+UCgXKOvFKUiroEGYdqDhN2am50tlo6BuSYW8n67SGVaoEoUrX0tkCouDVgsDbk3/VJCg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR0401MB3637.namprd04.prod.outlook.com (2603:10b6:4:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 10:51:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 10:51:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 05/21] btrfs: always read the entire extent_buffer
Thread-Topic: [PATCH 05/21] btrfs: always read the entire extent_buffer
Thread-Index: AQHZVjym1Lw5qAnMlkKy2jetUST8va76GX4A
Date:   Tue, 14 Mar 2023 10:51:53 +0000
Message-ID: <4b0eed78-631f-bb89-28db-e480a8ad9022@wdc.com>
References: <20230314061655.245340-1-hch@lst.de>
 <20230314061655.245340-6-hch@lst.de>
In-Reply-To: <20230314061655.245340-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR0401MB3637:EE_
x-ms-office365-filtering-correlation-id: 2642b520-5dda-4463-523f-08db247a1f6f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y4IkuZyXUuVQZdfI/u8zQj1IGJKAdF2wjtRuLSuHQME3dESljr3TixrstQt0FEyYjXIJFk0asdnb+cQ47LkNO6nkqr6ap3ssQqY14I8Saef31GnsW8zP2BiPj1e7Ct3z6lSrMNzPh4jlyjwcv29KG1t57TtrfozgQUpFrtbBUl21mY4UHBFIRocOAaW5klvc2c8jmmrLWSYNhpCjP9u95IOhUSb+NRC+I7W/eCivm0bDtEb2REsSP2ThSvISuULEiQdGQpelehNqeTEl5po0glpEI7MFJERbGAIbh5D+e/DbsalkdTU6dHO30pqpsfT57gwIBw//gaiCjJ8LOE9LPOW6SqdwZbj+eDSRIcPbYxc+CDUCeDhNC1Hqgt2OL0wir3CO78UnS3xyCKn5WM/GrrFVgpnvqWHfBVpNAX/4rbFzlP2oa685i6D3GgmSuOJqTRoYIqeepY2fXYD5mkDNOFqlPIOqQkcCbWstg7EzKXlYhAePuYVc7oyyJB1xt6iyB5IFAMZ3jq6oGppGO1Lkjj1rScshml6R7Ih6SJPLFcDMkCu1n3TQrp9GnTGy57WkGabPEx+JAEo00aNiLxDePf097MrDM+XaxizUCxIQRmrFXWF3OXgtMIZc/0a07jwaiuKPAjjhTEsqORGuuDHk/+F6q3lMQpM9UTrA0oW4Tph3bLxS+vkw5wrnkmktME+njWhQ5ZxO8NSGBl3CrHx1yDnTIDCNQmucVbXojbBbxllHSTqowqoBE86cfGuG0tJhf8ZexQbgQbCSx4Ofb/o7pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199018)(2906002)(31686004)(122000001)(19618925003)(82960400001)(558084003)(36756003)(5660300002)(66476007)(66946007)(66556008)(86362001)(8936002)(8676002)(66446008)(4326008)(64756008)(38100700002)(41300700001)(91956017)(38070700005)(31696002)(316002)(110136005)(54906003)(478600001)(76116006)(186003)(2616005)(4270600006)(6486002)(6506007)(6512007)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUhlalBLRGkzTnRuR1o5NzFVeDdZc1A0RWZUNzFpeklqMHVKOEUrYjFyd3Vt?=
 =?utf-8?B?eHhxVEQ1R2hiVlQwSE5NUGoveE5pcTdhWjRDbHVCUkdwaTJBVVhublZOR2NF?=
 =?utf-8?B?ZGduZ3BZZnNJZVVHYTJLOE1mejZGbDQxclM3TndTTERCaXFkUkh6U0FXaHJW?=
 =?utf-8?B?VzZiN2lKWW5qUzV4S1VCUHNCMldxVU8wbjloUVYyV0pSM3hJZkFEL25QK3VB?=
 =?utf-8?B?ZDk1NTZqKy9qczJVcDFTUzZTZmx0c2RUWlBqbjdNZUVyc08xbXp2bCsvM3Vv?=
 =?utf-8?B?eitDdFFSZVpORFdRdDRLSFcvNDFPR29sci9GWDY1TGtKdXZjQ1BIWndySnRD?=
 =?utf-8?B?TElKMGRzblh0OHFEYXlaZW9jUENldFZhU2VjYkVYaU9QV2JnRXZ0cFNnaTAy?=
 =?utf-8?B?YllYZ1g2aVdXSE9TM0R6elQ2N3pzSWVkY1lQYmdJa3RwWjBxRWVLREtsU3d4?=
 =?utf-8?B?OWlCQTIvWVZuMEVDcGF6SE9kaVl2ZS9tVGIySUpXbGNRYlArYzdPVVEyMXpX?=
 =?utf-8?B?QlpCc21MNDdYTVpMZEdBMHhVbjJZbkFRZUJ3MG5OS2dJU29qckdSV2JWSkg3?=
 =?utf-8?B?aWRHQWpwQ0pzTTcvUHNLRGUzQ0xSUzBKVzRzTnBia0M4ZjBQSnM2S3FvMi93?=
 =?utf-8?B?dGE2RnozV0xoLzFkZXUyS2hicWppOFdOL0pNb0pRTnBsWGR4WVREblVpZkRX?=
 =?utf-8?B?Q2twSnlOdlZQbzI4MFkwK0NSNDVTTUJnanBDaVBiQTcwdWJnUCsvNllBWi9v?=
 =?utf-8?B?eTkyUTRWditPeU02bHNvZFJSS2d4aEY0QVlUWllaVVNZaDFJYmw3S1BkNDcr?=
 =?utf-8?B?TTRvajAzT0lxQTZxR1Q0bjVWUEFvb1g0dmk2V21JNW00ZWF0MmNxbDJHOE5P?=
 =?utf-8?B?eDJYTXZBcWJkeUJkK2FKSWxHd2lTbjZDLy9NWS85ajZyeGpjUXQ4OTJCVFVy?=
 =?utf-8?B?cTdHdVN5a3lCa3pUMVdNb1NPQXNCTElXZi80QkdwOW9Da2ljL0R2TWtpcDZQ?=
 =?utf-8?B?ZjArYTNuRk52NEtYVlVzZjNrSCtyWm1rT3gwclZLdHBBamhYS3laL2VqK3pH?=
 =?utf-8?B?VVZDT3FCMy9qWDBpK0h3QkFVRXlDc3docVdicXZRNlVSOFNvOHFDL0FrUktE?=
 =?utf-8?B?U084QXdLWVc0T3JhZFBlandOK2NlUDZ4ZlY5ckkrOTZpOERGVGp4QmFFMlow?=
 =?utf-8?B?WXZtZFhyTktWSDNxRWs2aDFoM3ByODRMWklsTUMySTZDTlB1aTU0SFlwMm1z?=
 =?utf-8?B?TGh3WXFpWlNzQzdsU3lVenpndEl5SGM3dXp3V0ZaNlNlTjlrWGlUbmpvcHdm?=
 =?utf-8?B?aEl1eWZ4aW5IOVA4SDFrQ1REeElwbUFNZ213QnRYYTNkdVFjQ0FtZ0g4KzVz?=
 =?utf-8?B?c05jM2xRelR1WkF1MFpoMld3UklkSHNadERuVGhYYmVNdjBHZWxYRVNWUGlv?=
 =?utf-8?B?OHNnK1IyclpuTzlONTR1N0oyUVFwOUZCdnBRa3hHSjhBQ0RLRWZDN2djY3px?=
 =?utf-8?B?cDdnYkVpS3B2M1lCcFBndlJLQ09OanRIYjdjV0tuZlc1QWpHSWFydW5mTWha?=
 =?utf-8?B?MWtvd2tESWFwTkhablEzaHlEOHFlNFJMcE9vZ3ZPZWtxRERaYXg1WUt1TGZx?=
 =?utf-8?B?RFFsUlpwRUVkOTZjZWFCbWxQMnpTQlJ0RCtYYVJoc3FWTDVaKzZYU1VVQ2ZM?=
 =?utf-8?B?bVIydjlYNkQ0ZG43R2tzWEdwYUFCUVUzdUZCYk1Cc0Z6NDg4SkZUaFpaYU1Y?=
 =?utf-8?B?SGhONTVEV1pCSXdveDMvM0lTdTFmcksyWkNsd285UG83WXF4VzRkbENScTlV?=
 =?utf-8?B?eXA0UlFIYnc4Z1ozNTdTckRSRG1UaW5VcUdBbDAyK3Q4d2RaZWpNSjc4T29h?=
 =?utf-8?B?V3puTWpOdkl3VDlkejJBN2loRXl5cmpRZmUrbnJmRUwyU3NPNXdXN2pBOTY0?=
 =?utf-8?B?N1gvb3pRVWRrM0NGTlA4ODJyYVRManRoMDljcDh6Z0dJMXpmTmVKUnpXeERp?=
 =?utf-8?B?cHFtdmVMb3NEOTd4aHRlYmRZdTZQQmM3b1VlZmZCT3l5ZlpaWjBLSkhwdCt1?=
 =?utf-8?B?Z3JvWGFhcGxKMGNJcU1BYjZoVW5TaDNLUE15d05JbHB3UnpvVVFMOXBNT3F3?=
 =?utf-8?B?WnFNYy9wSVV0YjlWTHJBZnl1ZnhGeHhaR1R0TGxNTmhzQzBvanpRN1BsVnpx?=
 =?utf-8?B?MlFkZ2lNcWU3SmY1SThDQTl2bktJbHVPQS9tM1c4NmpxVTlIZmNXK080SG5P?=
 =?utf-8?B?MVQ5L3BXRVdnYmYvZjl2K2lPNktRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAFCD9AC4746844B89294EC8B286BAF0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pwJclx4anw6F+FHMKde4FcpEKGy48ObYdViLO9M48BqMkloYqCQyW5Ae0vbEGK+mEOhApA9kBmNlNQ6krjg3ULX5Dj6Jjn7M70h4X6bBhPOTZ4CGhSezXGevLj2ocGXjC8HCfdndq8qp/Pd1QS3IVnkNvVZFg0BwcC0ZJqv6POIqSQKZOKSabL7MBTEev+4uY1xTlVWpQSq8f60O9U2wCtnhhmjhyu9Tq1Br/Hp8tqzt3PI7II14GqrCs4bzpRrXgx+w6BCzlRgdmH1NXmYlclhP0HPmkh5+kExjZxQOrMxZ5ouBjV5J2tvSKirMdQcaE+OqqyVSePEQ8Xi30Wt8g4qY6gIMax/wuVBtZtbFA/3QKwdpTFfRjf7kIsE1VGC05XxDwazux8LdeZrk7W+st36iH4up+Z3345/Bp31UUz0h6lrer2gF/r7/7G/2ketzN+lvrzqSvd5YavxZC75AwnUckXNQrVRbp3Ck2yfszCRSshg41CwS1UDvLDxN3f/BhJ408Iaz6qwFzlg74XRK0gjqyfhYfJnMq+d7hBid+plF/wRE9u4kyyrwSiScxkGvGRI4op0k8k1HsmtiiRP77CEl/DS3EsWF0Yc/mMFCa84A6Lct8cqVjui3rS8V0yYoTlTCGKnQzwoSnLSKP0WCMlym3JP1NE21tzwgkQOw1qFn57Ra/rIn4abVjqv/GcpxMEtmoSQoXnIneXyqVylKbzmtsc74eEZ2AOlUrfBqXqSA2Hby8Ra5kfsjMvLsHrCWHQ75cZcAVF1pYXxUSQ97nYid1FuqLVC4p756A83JowlElSO0onY92kf/Ym4OamDkXVTSJh6XzC96Tbf2fKGnO7TTMCTtLmv6Dv6ZHOndEz/2/QM+2huuhBulg8+BVPyV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2642b520-5dda-4463-523f-08db247a1f6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 10:51:53.4743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8iL76c0fHd9GSQWWOAXnHyhSp8/r6QC1/eHCXey6jLGv3d6e5skqb3T+DE1oUhTfH7bdNEypAhIpF4BmjeqzLMPpZt5oU2FDyIU52IUJ88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3637
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
