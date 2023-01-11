Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6759E6659D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 12:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjAKLPY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 06:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjAKLOE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 06:14:04 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85787167EF
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 03:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673435544; x=1704971544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dcFseGETWhVnXA34uCatQQhzNXVU9Ae6YfpgDrsbiDU=;
  b=HbEHL4nw5aA8Y9ixIxQTE7LnJjOmbQjOqFcwh8tPOuN39ltnAHTeKnni
   j0C4tJUT9jTV3ySsOO1apK6VmZZ0/32VjxitDKR6bU0Q5S6eCUpBeJYj5
   qKCuNXiBRbviPbFkSaK++XwKvCkhmcHPsB4Ci59qPprhAPGgueXq2/S93
   DBYbnaNFz0rUUjqlfvpl7eYzN/QO3Wfh2Ex7+pw61qBFfdyMy8ViaRY8O
   crJ//1nZzGGbJIxmDCo20ryiOGF2+mEdtcxSZ9JX7FqFj0uBQhR1LyZyY
   OOaA8mGVj+/ZFy0nO/XKi89mTbZm6N1Rea6LoqNxrdHSoRoxFMCWC6l37
   g==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="332531248"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2023 19:12:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0UCTfvyQhRJb01Zd3PkDjOq7DOMUELbJxSo20tPEq5jmtfahKDAMb16vMHoLCiSzfjpPiM7LUkY4NWx+T5RkYhuK/TOCPyO14mzUm/+W4Mi6ruPv18BUzGDxMpuv/DB9nOVyCyBvV0JwZ0rWe9nxNxloTwDQ4OpvsroxgUpu6BwlNV85pp7Jz/76sYducenNwNLpNtakX2c3O4OSGCFyPCV31mVhmXI8ugu/O9+J+p97HWN7kTr42vzTMCa70FvhXukysDkeP715seop3QA7lpVxu3u3UjHZXBYCbK7zM3BSnPdGiZUxiEm6Qmdw8Py4D2FuAKg9DKYw427E3Z7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcFseGETWhVnXA34uCatQQhzNXVU9Ae6YfpgDrsbiDU=;
 b=dDf+WvOyDQV55C5MdoJ9FcyDOUcGcliQGc4FyR3uYcAvATh6fpMNq8QpED/b4Qo9Z8h4nlTBBAiBqzSYs8jblN36em8Py7FzRDKi94P2nOgMbhxmvKJaBJ5IztYsAQnOaMvK8nA97svGDuWbIiWDD+CmhMHGXJ3jyWDkiUI6B2we6qVXz/eYsrvqZUrlNpPduc+7cLrzeyyhaohaFmHhw9C+QfFIEkyZbaiH9JAClcYPgliQIs/XPrALtR42M2C2NPSuqwzMsz0zZvNVe7T82k/y9YtXBGFg97r+OHv6PR85DbMkVHh7SblyS5azH0QRTJUZbWI4YsNQiaisf9YLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcFseGETWhVnXA34uCatQQhzNXVU9Ae6YfpgDrsbiDU=;
 b=Jk9LnKnm5xlZH92UfEdvq3CoJdSRRUA0cCei86NYjxheZvX+KcbVm6RwP8JvrctjcBea/RXKjJ5c75V1zdT0KpAqUQGlkpPTFTIA6Mp+R9gHUtMYixBATbptCacsLsFxH9osf35qjETIzZs13Dk03l6MX1omkiHxqyve2S1iUD0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0491.namprd04.prod.outlook.com (2603:10b6:3:9f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Wed, 11 Jan 2023 11:12:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%4]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 11:12:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/10] btrfs: add a bio_list_put helper
Thread-Topic: [PATCH 04/10] btrfs: add a bio_list_put helper
Thread-Index: AQHZJYVeee9y/7S2L0q0pNlCtxRYcK6ZEBoA
Date:   Wed, 11 Jan 2023 11:12:21 +0000
Message-ID: <2e946375-bfdb-7361-842d-c0b40e206298@wdc.com>
References: <20230111062335.1023353-1-hch@lst.de>
 <20230111062335.1023353-5-hch@lst.de>
In-Reply-To: <20230111062335.1023353-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR04MB0491:EE_
x-ms-office365-filtering-correlation-id: b6d4c1cb-81de-4ff5-c253-08daf3c4b59d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lZFdm67J6wvYJOdQnkGYsukfHnA2zIRLcMTnWSfLvJ/R2EZr2/xmczRoubCapHFErD0KfKReB9gw0ulAaLOuYb5ccCYr0MACpANwFHQdz/tXTn65nfZOOqcRChWATFlpMIqyOwstOnH+bD7rGLixKq6J5/UhaaAMzHKNIjL4Z8RRCXsnjJSkfw5BsBR6un1VTQE31WOz8pvgaNJhykBIQOib7vhFdObChNGQi7eR24uqXP/qHr5lI7JBSQ+2Bde4DXssB5Y1l3noepB4e2qrladn/cfTi0kG28LuDla9sC8pgrpf5CeRQXhg1Rsd8ai12WGeaYQGHyacJnYaOMFvx4Kep39/CQmeTAu4enmfTLmlyY4D1D8nnR5F1UCbuVT4N0yvX9/qNxBciHiuae58CPEewHe401S1xgs6kD7YINSwrWLk+FWfVAY6NGqfFajPkjrZl7KWD/zoxAdMxAJtZyi1GGkFYq1aXK29Dhj5xN4YHSmHiv3NvjA54eA2nCM66cQvCS6DZBnu5I39BkhQZUrl6rq7ngtiBXc4YSmfBilpA6EGaQqYmcrLINCQDc1i9XaBWynS+ofWkLLl/Rs/m7NkOmVkeIw5mJ1u70irQA2s/A+viqAIbXHazXaKNh012ZsuASRxI2HXpAw03EYrVeiW/A1Tfz+T+3VWH5ZGbdRjVY9nbtw3ri+x+Hu6vbiFTTEHoqYWduYSNnJW18OtgPpTjpNb//yJKLfcihf8J0wCzqNdbmh+h+MSf3Cf2qejxZvZNjwsb2VDUdTwei1YHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199015)(6506007)(6486002)(53546011)(2616005)(4326008)(186003)(66556008)(64756008)(6512007)(316002)(91956017)(66446008)(66476007)(76116006)(71200400001)(478600001)(54906003)(110136005)(86362001)(38070700005)(38100700002)(82960400001)(122000001)(83380400001)(31696002)(41300700001)(8676002)(66946007)(31686004)(36756003)(5660300002)(4744005)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFkweHowQSs4Mk1jQ243b0I5WlJTci9QMzFTZkZBLzFQTEZSdEhUU1dwNlRM?=
 =?utf-8?B?UVUvU1FVb2xVMU5Bc2RCQWhCWkFxTnZ0QThtM1NWc2R5cTRlcG9FdmpaMWo0?=
 =?utf-8?B?ZkFDYzFEMm5zVFBCdCtSR3JUNXdWYmgxU0h4emdnTHNUSk5CS2drYWVKSzl3?=
 =?utf-8?B?M2ptWUNJOEp5ay9lQkptcFdta0NRdnlIRGdzbVVUSkxWSHl6TllDR3BaZEph?=
 =?utf-8?B?eXJuM1VvWUJHQjZQVC9YazgwaDhFYnY5N2ZIRU1jQ0I4dkhWemtWRTlvVFBO?=
 =?utf-8?B?dzdsSDFsWE5zVVc3WHhyMEkvNlZ0cDMwK3VYbzNENmhmRmJJVXcrMTBDTUtr?=
 =?utf-8?B?cENZT1hjMHhkWmZ0Y1VRNlZrSzRYZFNXdnFFMHFRcXpabkZrclB2QkhDb1Qx?=
 =?utf-8?B?aVBWdzh4UFFmV2loRVN6S2NmMDBKUEZpejFQeHFqY2ZwcEE3MjEvYzd3TW1w?=
 =?utf-8?B?dmxCSjRUQTdlc1FBRG1qdytOTG9sKzVKbFJOOUFBVWpOZkxmQmI4QlpQVmRR?=
 =?utf-8?B?anhDV0ZNdGtYanM1cXZ6QS9NUURvU0x4dlVscEpIelgwdm9qRllZT2tpeGsz?=
 =?utf-8?B?VnF6d1hoaVNkV052Z1ZiTER1U2RnN25xNnRLN2lVU0ZZbUZBcHRCeU84Y3o2?=
 =?utf-8?B?ZHlPdEgyQ2diSlptTlJrYTQ3aDFpenVoaE1qZEZhOWVJcHdEVUFTdGVzRjRJ?=
 =?utf-8?B?enFWTHpKRDJkckFKK0VNOUhPYWFxYlAwbTV4YndabmkwYU9NeUhRUVJYRkxq?=
 =?utf-8?B?N0t4eEdBT094VW40TDFGM3FNalRlODBTU2ZTWm5TbElGNUx5UEpKRjdxMS8w?=
 =?utf-8?B?MjhBV2NzVUhDclBYOGRXQ2JFRkJBU21XVXhYTFlNL2JTTlIyQ25HaTlWTVR2?=
 =?utf-8?B?bjlLVFhzam1IUGNDM3pGVnBGQ2FIejU2RjIzWUI1TVRpeUdYak90UC85S3BZ?=
 =?utf-8?B?V0Q5MGpNS1daaE5xMCs4NHdONC9nelpBK2R6bGREUEZ3dE0ydmJZbDFXRGdC?=
 =?utf-8?B?UGVUczNaRW5DOTdGeFVmSkRtSUdiSmhiY1Q3bUM5Y3NPMVAxeWZVZzdpVkRP?=
 =?utf-8?B?Vy9xb0tNK2U4aDlvQ2crWExWWGZmYlE0bUZ3bzZrbmFCdEM1a2YyYkM2Nmdj?=
 =?utf-8?B?dDFGUmtQR3B5ZmMvRzhUNGdBcXB3QnRKbWp1ZGU1bGgydWhOYmpTOVM4QUY4?=
 =?utf-8?B?NllURkJ3c2Z5cWY1KzlQYzJDOFRLWTBHc0hmTDRNRE1ub2tXdzRSZmNJU1Jm?=
 =?utf-8?B?QTRuTG50UnhTOHNBWkxEdXlUVkl1MmI2c1VXMnJCaThITUEvd1JXZlJGYWxs?=
 =?utf-8?B?d2l6eFl6R3Z0azIzT2dQcENBMUVibXV5a25ybDM3bXp6cDRMdCsyMWxwbXhG?=
 =?utf-8?B?VVB6WFJLRFl6OWZuMnNJUzRGRGVLR2t5aEFDWTlVOUN0eUVFNUNXSGJya29T?=
 =?utf-8?B?cHBNZDZ3TEwySWJNZjd3WEZ0clVaYjdGSU9NNlhMMmJYSDdsbzdyZ1FLbExk?=
 =?utf-8?B?d01IZlpFakxPa05QZk94U2tBVVV1TDJ0UWN3S2FSZEpwdkRoazhhY1hoai92?=
 =?utf-8?B?TE1UamdDa2NqMGJmOG1RT3hmeHZFYVc2WFNQWFd4L2oxUkJwMkcyY2JWakJz?=
 =?utf-8?B?cWJ1NmNlZm5yb3pjaDRlM25LZXZBR01HUFZESGhCWldoZHh1UzFnOFUwNytI?=
 =?utf-8?B?K0VGNHc2K1ppTlNnUGZ6ZGdDL1ExK2xwZytlOWxyaUZLRXNLbnF1TmFRaURT?=
 =?utf-8?B?QUR1Wm1wUUU5bndDVmhDbGtPWnpsMGRuOWV2R1hCQUFJTWM4QUEvc3BqdFBJ?=
 =?utf-8?B?aWdLd0ZHZUFkOWZWUHBMeW91dlR5TURReklHOGR6Q2V4VkYxUnkzTFVRN3NU?=
 =?utf-8?B?b1hWZlNxY1ZrR25OUXZjc284VWJRTEMwRm1mM1Z2M05QRFUvajZzQlE5OG8r?=
 =?utf-8?B?ZVpjcUVEZmpUWERVNzBvd1pvVzRVTzZQdTM0WU43WXdCT0dJSFQwSGw1NG8r?=
 =?utf-8?B?c3ZkQnFzSGxBK3hBdUUwQU1BOElkbDdXVDRtNWhiZmdVaVZ4WGJ3a3FWRGoy?=
 =?utf-8?B?YXpZd0twbmgyMGNiUXpiUFJvM003d3FTRVYycjEwTXVLL0w0MUE2SFJpb3hQ?=
 =?utf-8?B?RHpmTmJyT1JwcmxxYjZ6Q3BNWE1oTm85c0dhTThNWVovdTlXakIvb1VOamtK?=
 =?utf-8?B?ZVNXUmYxSnNYWWs1TzFFWURTcTBHdXFqaDZ2b0N0akVwQzdEQ2J6SSs0eDJu?=
 =?utf-8?Q?FuAjV1+V5G+QHuOGObSqMhGLXBC5VlKO68gOdgJsH0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14DDBB39F7A1B6459B415B566EB0B1D8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fsKCzaK6EjC27SZVIAO16E4pjNq1+64d+hC7Q/9xJg3UtotCzv+OlJAW3GO61LkdSvLzWYQkMoC2atwCNe0Zk0niyxLhZQNe50ntG9n9sJ2sqYKvWM6sotbeUQmPr9yU1xFVLXW7l2iUGL/DRL2ktFH2IEKQE1z5dJ9yVKo2Kf+XMqHIrUeNjfIshvVr+fT4td8B300n8+c3a2C6w4Szsfdt2zhTj8AnBjmLWnazj2YBsK0wZXQiz5vnQP0/TE/qomvSaV2ehmSNwf5emn/FC0EJ6EBTj8Tqhk63kmNR/TASsW0ZraivZa4gvGE7eQVmavYutHC7I4UyVb7QawgynMsY38+53C5fs3p5aLU54CSQcYEqVZ5J8A04lUW0zKr138SmbmCsZDDYhHj63xVnMPJEjXDo9pKCiY24nDWeMsSUfDBb7oRw+Nwbs/BD50JXbFQDYMlQip+AXFQSDaMEb7dzAuSZPem14OFj0JXWgsR2G5Wu7ZkCGIG3g9R9/EVPXw9vdpxV3/jYIjTi9uBCwmOIERc5wqs7YHEWX5Q3oWR/Mugb1FkIaOinIHgTn7Fn+yntK9kA3+UcXdLBejoJfbiJx0uBZSyGtw0sUHSeNZm3nHTDb6zEaq9QFIhnzsIXXEyPvydk+yKQM1qtD/17zb4bxEPeXtL8bNJyXMT39SvYQt5Sq9RB8LOvt6oFstEFNrC1JOojzPPxJyxX8k9SgNpsABYcPOMcOpeeWyqItmzm2U3mNE7ttr5/jSPLL8MF8u5amxA0+m+RF6DrXNsKqUFJmwsHIs4zfVZmIrL5CZdQQsOzWJr+FjSoyXQQYZFSAnhpHFoAp8huO+txjaYg2RK70d3rh6vsWWSEhG28SqpaCh6UcElEE55Xp4nBdldm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d4c1cb-81de-4ff5-c253-08daf3c4b59d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 11:12:21.2345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZL/4W5sxoWZxJbiw87yh4II6DAT9sPpZnwS0Fkh1GvqeOs7fyX2YaheK+lXncry15bECE4/KP71z7QAf2s2TIR2ZzHys18wBJzILSQBzeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0491
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTEuMDEuMjMgMDc6MjQsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiArc3RhdGljIGlu
bGluZSB2b2lkIGJpb19saXN0X3B1dChzdHJ1Y3QgYmlvX2xpc3QgKmJpb19saXN0KQ0KPiArew0K
PiArCXN0cnVjdCBiaW8gKmJpbzsNCj4gKw0KPiArCXdoaWxlICgoYmlvID0gYmlvX2xpc3RfcG9w
KGJpb19saXN0KSkpDQo+ICsJCWJpb19wdXQoYmlvKTsNCj4gK30NCj4gKw0KDQpTaG91bGRuJ3Qg
dGhhdCBiZSBsaWZ0ZWQgaW50byBiaW8uaD8gQXQgbGVhc3QgDQpkcml2ZXJzL3RhcmdldC90YXJn
ZXRfY29yZV9pYmxvY2suYyB3b3VsZCBiZW5lZml0IGZyb20gaXQgYXMgd2VsbC4NCg==
