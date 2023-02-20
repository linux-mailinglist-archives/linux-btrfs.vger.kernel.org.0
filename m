Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145F869C668
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 09:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjBTIRv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 03:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBTIRu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 03:17:50 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F63510F9
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 00:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676881068; x=1708417068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=OqtUx2vUSEvG7ymJn5B6UNmuLn0yr9tCJvrzC3W06gZADiyu1KzNYx+M
   PjEOakOyhO5M8ANSvW/P9DeCeGDAymUuz5SQyfoJungEhK6t6eKz2YMw4
   UjJtF7HpxhWiEW5ZS9dRnJA0hbseMe5+EKcg5N49owltsxKJ3QJIsbX3O
   W20hxQY4JzCZPu9F3Y+hKVSMqnoEOlnE3bgNOAjVnorJXNCAUF/WXdEZR
   fr7Y2+Oj7BlQ3XJRP4bTpBw/dcr+Z5LXoWQNkZF/7YtlaFqU9wfFIAU+7
   8NKydOJrRF+VK7Lpp6SP6WOY5BwcpbK6LHBCJjoE0wfV2xzz9asVGDeCN
   g==;
X-IronPort-AV: E=Sophos;i="5.97,311,1669046400"; 
   d="scan'208";a="228687063"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2023 16:17:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViJ44s5clhUA2X0mjhifaUXQkyMbD4AUzqlTTI/QxzeY5fT6j4MOJ6KDDm2IUypYdeCbXXUOVzoEuwsWfFF0Ia6W9qUXP4fUwihoVpFC1JDvuAPYYr8TIhrbI2mchRQl1cxn8rvEzOAv81SKUOfvNR9fjGG88EORt16v3jwdNArnr2nZ2gEdBAekpIrCUo3unaj4TwdJfeSz7PgOOY3r9v7g91jTzXj1iDeFlkfK7KTO36LGFyZoqBCLrGgFlBnbT51zAzZeCY3jQpwdVrmw9osctBE1e1173HVEPajstVA9pU7Mo2EDy35n3rhdfrrEvvHYHPHGe+XEXngq1WPpsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=NoynkYcGD774HdlW3g2e723QpYrFfEk1PDcjJVwHaczhT8vJ+pFfz3n1ePSwoSCyf6E0BOw3x4RjIy5sxMQHS17mSOO3Ulz7Q08U1CVdlEF8KTda98mBG5bGe1UtN9PeMK+ZmKg8RU5MmEInFe8wrOQEfIlq+NwZzV+HtRIzHi26AGEKtUtkZJGaDGbc93yYDhVYyNN8OtSnAyOf5flaW4LV7KfQ13VO533dlbnTnbczzi7cgFj/jLtd+lZkdzD+s3PQr2sQS4nShrDwF9w+5My4CppePcfpzxbA/MVA/2qG81mT1jXNVbhLtoOormS7ozbXB+08iQp0agBzz4pB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=VNSAJwaU67Am7vKGHRFUd06VAndtEEeoD1LcqkcSo5BvDw3rniD1CAp6gTcDPUb9ndodYNqHCCef9+3i07NnGNNdW/Hk9T76JGNMw/JuCdUj4CiSnbBeqN5vafC4jAiMHXu6mpPYa5FVopF9orwJcsnXAHVa9s7EdWFLEHoPdqc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB7906.namprd04.prod.outlook.com (2603:10b6:610:ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 08:17:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 08:17:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: move all btree initialization into
 btrfs_init_btree_inode
Thread-Topic: [PATCH] btrfs: move all btree initialization into
 btrfs_init_btree_inode
Thread-Index: AQHZRI1/i8kf5tdIn0m5pdd3Wx+iba7XfoGA
Date:   Mon, 20 Feb 2023 08:17:44 +0000
Message-ID: <942bb4c4-cbf7-212b-c83e-6096debaf583@wdc.com>
References: <20230219181022.3499088-1-hch@lst.de>
In-Reply-To: <20230219181022.3499088-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB7906:EE_
x-ms-office365-filtering-correlation-id: 4637d886-9ffb-4c78-316c-08db131af18a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I3T7uz9G51JQdEppMgFJZf+8//Vx2Je/tdQm/eo33EsyV9Ge1PPjoNuIdaZdmvDpOtZrip17F9vB9QKoG5TUvyGe2L13+q+gAnq6l1c/mIuggV+iLEfL+bPm5XDcC4sHAD14hvYw4h2nhjX7CsI+4rUiG5elIhx/+lslH2iRjRhl4O4F7qUKuriWqMSiHrUYHAAN5tk+FkFkETscFmWbOC7AjdzrZy69IFPQsK0eYzisSTo+5nH6bOs527ZfyLIDDBsO0xvXwsjoBrhUif7SgXQYE+ruIbrEV4a1uiSwuXPs5X2QWrzxPqaToP1TTITZUs6s6/3iYTQ9elZq/l6+1y46Ic015OjeDvQvbdLGg442ZaY2rwk5Xu2D7nGaBVhcXRyr10eAaMBL68tVXzglCVQm2CfZZbtwTkcaZBtGDQUD86nwfmrtu8XMR1bDSNwT/nQnfsC7bINo8teuxr0Vy1TWhEWnS4XdrAPRUbJXGjmz2bptnE+y8jEpqzZ1Kqi9M/4fwgJlNbp3HzscRdzw6zp87JeC46KGrQNaz8Y3K7jg2W1wwqV6lrRd70rWYs+X6N7Z2R+jRWDhbJz13tEA2aF/bS90HwPwDD/z8f9z5RKo32MLZafdGTz7pq5mCHvSpyFgJpodSmNIS/DVypKT4DQQmQVU2jyMy6fP8YPOcN6TPs5dr8wQcINRkx1a4MA8Bk71d5o1vb70KBY9YMI+kEJFeyr1QQovV0XvyJN4xph4eXQlongb1l1r0C9KB88wgj5wAWBUzBDwzRiYvhswnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199018)(110136005)(478600001)(71200400001)(122000001)(31696002)(82960400001)(86362001)(2906002)(558084003)(38070700005)(38100700002)(19618925003)(316002)(41300700001)(5660300002)(8936002)(8676002)(66476007)(66446008)(64756008)(4326008)(66556008)(76116006)(66946007)(2616005)(91956017)(186003)(6486002)(6512007)(4270600006)(6506007)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlhHUk1uUUgzZmRUTGxhYVB1WlQ3b0xCbzkxdEkzYmZMWUpxYktHcG9SSWVx?=
 =?utf-8?B?N0VsbC83OWlQVUtkS1cxcmcrMkx1TUFXZFY3OGpjQ0tUSWNCTlVFRExFY0Fs?=
 =?utf-8?B?ckI2dDZEV3BKSmJIalh5eUNjcGNyV0FiSzJxRGRCekR3cFRXY2xtdzNYZUsr?=
 =?utf-8?B?cjhYblBpTVFTYjZFeGlDcnlaN21QaGFZbzAzcVhQcWFUcUJKUzM4cSsxTGpB?=
 =?utf-8?B?L2xsVXRIbk9lMFBKbmNZQWhWN29SWnFMSEhZUzlZNzIraHJHWjFyaURnU1px?=
 =?utf-8?B?SlR3TXJadG1LM3pJbFdBUjlKR2xFK0dNbk5XVXRHdmlYWW1nZTliVDRlUklF?=
 =?utf-8?B?bG82Yllsa0VJYWx1SUYrQU5BeFJBY1dYVVlVT2VCSTVCUWNscTRIbnVCbmlC?=
 =?utf-8?B?SWxZdDBRcjJ4UytWenhwKzl6a2xrTVFjNzNSeTZNclA5UE9tNFNNTkR4UzV2?=
 =?utf-8?B?TkRqNkNxNlBwWmJ1OEExMTZzVVZjZ05QRjljQXJ5eWt1eUVkWG1qWVoyMXhs?=
 =?utf-8?B?RHdMRXV1Wmo3WWxVNWpnNUh3dXVPSU1lT0FDU1NYek9UR2pUVTgzVnE0aUZu?=
 =?utf-8?B?Y2Z6a3R6TDVPTEkrVlYwK1Vqa0hmSUh0Z04zQ3JRTjBodlY1WXRGRWs5REpX?=
 =?utf-8?B?TVJ0V0x0TC9TMlV3S1dGTnR6dVluOWtIZ2J0aE8vcUd3NzNlSjVla2N3Y1hH?=
 =?utf-8?B?ZkZHdjBmZzJ0dExOSEt4bk1pcjdMWTBROEJJdG9YZ1ZNZ2M2S1hCalVNQi9h?=
 =?utf-8?B?dUVjVGtHMUszK1VHNGFGaWk2d05DQk8yYklOY00rOGplbzBEMjlMNmZEMEYr?=
 =?utf-8?B?SWwzYWIwSUdDS0VZRU1sTzBDN3F5R3ozWmtnMmZsMnZlUlYxRDlKbVVBWkdW?=
 =?utf-8?B?NTFTUHIzQ0p6eU1GZzlzaGNZTXl6bUFSYnlHSVBVTFdCSkRVRUt4elp0b3JZ?=
 =?utf-8?B?ZTJzQkZwcWpPcVZPNGlSLzY4UUs4NUMrcGpkNFNDNk56clRaT09tdERIZEVz?=
 =?utf-8?B?eG1DY2JvS29BVGp2VEFDVWRTbUFkdFBDSlh1ZTgyRlM0cExGcmpBc3lWOHU3?=
 =?utf-8?B?aXZMQjlHZThBRURZUlBVTWw0cCtENGZCN2hpL3R0REUrZVNHZ1VsQmpodmM2?=
 =?utf-8?B?NzNlWHR5UDcvRnRTUFlLOGY2YjEyZHQ4bEJheTBhaWVNVkRWNkVIRjNLUUZh?=
 =?utf-8?B?REx4bkhDand5VUVNM2pHMXc2WVRGUC9lL3cwZ1pESGsvTEcxaS9JRXhVV09B?=
 =?utf-8?B?cTBteVptOFJWeGM3Z0hIWWlWMklFYitsay9Uak9JWDNZY1o5aENLOEpqYlAr?=
 =?utf-8?B?R2l5emFSYkV2UThKa21UbzhUOEcxaGdHRjdURWxvMjA5MWo5c0QxekF1QmVi?=
 =?utf-8?B?Qi9XNHFzcVRoMnVacnJxSThrT2dXQ2lkL2xra1c2eHZycFBkcHVNcXVrWEZn?=
 =?utf-8?B?bEZJMjBnUlp4ZE9kZEJ1Q0Z0cDI5WHduMkEreTJDa3RoZ1kxcHUxWEpFYzBi?=
 =?utf-8?B?Q2V2U0hDRHdDTjhNTmdQQUpCZ3NOckVhamFWakozUTdpNktET0pZQnlSQVVz?=
 =?utf-8?B?RVoxRTRoMHdJK0tNckgzT1FjNEcrei9JblBzK1UwdzB3WUpzSFBTeHgvL1F5?=
 =?utf-8?B?Ym9UMStheTM1aUhVU0Z5K0xPcFYveGhaOVpIaVRwUkdENDg3cnlZL3orazBz?=
 =?utf-8?B?M2dnYnA2TEtpV3llSXhNR2F3MWhFL0FpRnJqeE1sdks5WU1Fb2svWUQ2aFU1?=
 =?utf-8?B?UDkzYTFjT2FyaVREcExmMktCeHZOTzRsdTNsemlSSmNzand6SXF4RUN4UDBi?=
 =?utf-8?B?c0U2VGpIaFk1Z005RVpOUWxka2pvUTZEMWdsL2dRcXNtQkRxcTQ3eTVpSmx5?=
 =?utf-8?B?dFZIZjN2dndReVVmeDJ3dDhMRHZjQnYvTXZCTVAzejNpemRxY0tFVSsvQm1o?=
 =?utf-8?B?VmFIZ1NsODd4T1VHNWY4RHlUTHl0djVzQnBJL2lsMzg0ajRpL3hKMXdJMnRD?=
 =?utf-8?B?S0NrSGgvSUxTNVlYdVlteXhlU21mYUFWZWcydlhXdjltVDBTYk5wYndQdC9V?=
 =?utf-8?B?NDFxUkorOE1BTnNVUkYzUDUxMDFmK3B5STVjTXFZcG8zdkxDb0IrY3I3U0RU?=
 =?utf-8?B?VnFTUVpTaUdNMTA3Y21NNXJjQlNzS0tZOU55RUsrR25KM3dvY01DK2pnVXpl?=
 =?utf-8?B?enV0TnZWS0R6VksxWlBFNThmcm1zdklGUlZkU2xva3UzUGp4U1pyVW5CNzNF?=
 =?utf-8?Q?aYQi9RnVubT7EGXtbCMjzhYDVwuFWBp+4OAIpwQHr0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <514C461738A2ED4BB1361BC1D53F225C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eyZmq1k611Ai87SU4Jo/jQJZeQaf5bH4spbfxkZP4jUU48A1of9u+u04aM29qennrT8jM+A7BvlPR1hBQnIKRe9AwMAcUEtEq60ftfwpwoAa4J7WsAGVaOPbOyO+s4PrrdJH1TYiaQfD1WC6BCjpjeX9zkFJYFWwaUpJaCQ7T9BFK3qPfmeh4PmebB/e/E+8NI01pJkLBmg4AAr/OiVRHgJAN7MltyzepxfSBbKp8knMY+bb3YrhHfigL9j7rKxuKHrwZbMNpUr5RjResg9DWzE5lS5gIW+p1toIMbiI2IsVVAMQfVy6ZFqToRIQI+P/ufJFxA4G+PJvV2qN7m9jQjwm4Lxp5Yab1VrOtDlQ9NAuw6KkRAl4ygEZ8udxaGdFAz/7/sZkBppttwvEf6yBoAjQmXIu5UHzw7+Gp0N1UjuMfYry8VaHwp2LgwdntCB4qWPsTDD+fCTYSrJ7Ja8Q6RFTsdfgs9ogVp1k2CrJdtswwv20Gcuf+Auusrp04h7RuQvbHlZxaTrEIUq5/5lLnb3MkX0ZAK5ZjZwO69TYRtz2BpmafUQhmQuo937Hqt708Md5rPMutj9KvFIMGNWCa2ZXzwxv1NqVbaTd6liNExz+C0sxTlsGxG+jnOGoLt72o5+F4NRlQAw6UUIxzfwTOuEb//AnDax5bvqAZrjawCgF2EVNTKO8ERIsGT/czhEX3pus/tdYBKHXS/+PSTA38ncCKtBkIuVGwUj0AxuBCnhNRK6Fv0swgmOGE6u75eqnYVS+29wJPwoT/vR/tgx1SkHaUGIAPQ6nnx4eJC99bbaUgvO89FtZnJjHUGdnS9rLQ0z76RYu1AmuFzQVEE5PZ5o179Zb+buR/L+JbhCdr1Mb24KDAeuzc9i+sNYNJ1xn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4637d886-9ffb-4c78-316c-08db131af18a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 08:17:44.4875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sGGZtDw+NwvYo/c7GktNPHLyadC4+D1hxyCVzDmzYzlQsjkd4aKFtjGduUcLKxlM1SXvSNOEY3T1YOhYk9YvfOcTyUOuOATshlQ1rWg5QFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7906
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
