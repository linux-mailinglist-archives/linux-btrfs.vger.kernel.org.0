Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AF1691DA5
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 12:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjBJLJm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 06:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjBJLJl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 06:09:41 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E71BE068
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 03:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676027380; x=1707563380;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WGpQ3erS4ZIXbftD33jH84gAM3/dObjEYA5NfbhH92I=;
  b=RUaXrj9OQqpWZb0A9WBvz4jBTdHmFkZ/2uOrP9E6ODNPquC5sF0G4cC5
   0tbdlg31Tm5sj8HAuUHI922uHUaisG7YM3ttBlDoPlDV2UZEiAktgTxHM
   ThzNyTHIQTwWp/s4YVkmTbvcE12UDhHn3wtnr0HGU3ZJ9Ka6rPgTLGFm3
   nnNBmFgySXrR2kKuLGvJSUifq/QEV+CLieTEvJR0dIKuzX3hJbv3vlZG6
   gTWBb9nHwPY7UKQrX45vKLSAmnJMM2MxzGnfS2q1Y+gMoEvREMQBkGcY5
   c8S4+56i76ZjirC8nMBe1OqBJ8yLRhQ4BkW0IHV6mrkcHxaeNlWjNHMkr
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,286,1669046400"; 
   d="scan'208";a="327298982"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2023 19:09:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPZk3FT/rIXxKyqe3KGjopM8ivqJB989aQ1krl/uSZUxeWPyq2WS/+to8yYZsSePCQRKzp+nkelxml8zO0XYbvcwETp3EkpmkMF5smQR08YmiWuAH4jUZTkf5p2o2Vd7qIalNTdidA0kPIsJkf1JmdQuSCUKrH+YuvA2UFt+OCCN5JRw+302pOSD574BvnEZf/a31Oo2o/H2KjaK9wfb9VGLePZdS3YEyms7H1mZMhh+PyKSRzHjNM35CK7+7D9EZAzFbbflyC+d4UcekpNCQzugdhuj4SuGv1KVmsLTSuLmBNsR1AbRSlbBpKMamGiPtqX4mO9qKlMIccBfM8jHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGpQ3erS4ZIXbftD33jH84gAM3/dObjEYA5NfbhH92I=;
 b=GMpEvs9M5N2xuPDUJ3BlgjIl5fLdfqE1TSj0EeqA1huzbYtMiKZp/lMEWApQG1O7W8YX1+5/gjN2UoNoKiKHbWTG9HEYO2ZxElOWvBjZrVMtkY68AJGXuXgDYZnvJWVRboKQ+GeFv8FHLajZvqAuLLYuKUwK243CvJcSGX035h3unwSi8NoSfgYEGgnJDey5nzP9unynPyMuvNtzQq7ZdS3hWJHeN+WHiOXgM3nv+xuwFD2sLvvY35dlBdoD9s5unbvbZtxJOKPQP/cQ98fS3rHylypZgJQsXQdECeDnJTheKJTgq8N7JAd+1lGYqZxQniqKz0DbKERNEkNrcfJl2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGpQ3erS4ZIXbftD33jH84gAM3/dObjEYA5NfbhH92I=;
 b=MO8EsRSWK3JdizcMn5e0P6y003krnS0i+ohOApY8yjRLNQ2rg7uBW1runknB+e4EJ1xmsaJARw4jMhF/jG201egNEOgzvm2dXU7IAssjDNQ6xrJPeUElje1DuooOVktnYpCgw4ktGjRgX+L/nYm8I3/PbPUr6ZSjxa+4CTFxCqQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6121.namprd04.prod.outlook.com (2603:10b6:5:121::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 11:09:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 11:09:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/8] btrfs: embedded a btrfs_bio into struct
 compressed_bio
Thread-Topic: [PATCH 1/8] btrfs: embedded a btrfs_bio into struct
 compressed_bio
Thread-Index: AQHZPSQw02v6UnKmkk6WdcpHTS54l67IBgiA
Date:   Fri, 10 Feb 2023 11:09:35 +0000
Message-ID: <1eec104f-cefd-4bdb-fad9-6682f1da7556@wdc.com>
References: <20230210074841.628201-1-hch@lst.de>
 <20230210074841.628201-2-hch@lst.de>
In-Reply-To: <20230210074841.628201-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6121:EE_
x-ms-office365-filtering-correlation-id: eaae5901-e1d1-416f-d3d1-08db0b574b47
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GZI7vS2jbUpOejcxpxOOmKk224GVq8MbkHnQu+jwu2tKtL/e2eXLatz+toHhFRf5Tztl/QYmafrdzYjc9G/6pq5thPTU44qoGQL3qZEpUyaiTnHFbVktMzfrHxi14Ar4nCGZXMAiLudpQKVNusIIUUtQjXgdUA7Y1he74cJNRq2L2Fi40It/ORwxi8g0YCcWgQOTT1zBjq9VMs7b0uMoDtefstozm/RA2gDl80p9cMeQNraeXX9xJqPC1LCE9AtWAqueJSa0bWWnQhKf2mHBX1T3AONRSEdpDUYmAKZnZdjh6U1lbPnvC0+sovDiNSNsU/lLY3DaxuU6BzCRxb3h/vaivDV68uQ3Yi3KV6Qa8I/Z+o5bA/DDiqj9V0oJLuueKSm0o91G5bFJjxjM6oLG1+WhuOh4TaL5XwNDCNFWBdNcpFRcM6Wp8ooHNTbb3FRqvgtctXcOnX48pYBSSrUaEmN5fxiIEwz+9cXahgWfo3QJKoG9XiH0imEUHamUg6fi3WEIRXoUzsudWhrMQ5O8txJGvWdSL/WPC5TGDKhwRoUS8hxdOrJBcgMPgSJwmtSAbEa6EZv+5oKYda34SWWcWb6RjOJRAcWEJUF7/AMDK9kfT1jBIcPuqfg3XOQ8w3A6rgNwW8WW+lqUqfhd1yYn/hEBjUc5OavSVgJARSZcA+26dgUqtzxQBMeP4DJNjOsQMXS76nLJFRm6/cAX3NfV/yD+0cGX4voY16i7bkt1upBP5JtRWlK5o9tM+rNpK1QFmRpMA4Fxv3MLBol6L2J5QQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199018)(6512007)(31686004)(38100700002)(2906002)(316002)(8936002)(186003)(53546011)(6506007)(110136005)(5660300002)(122000001)(82960400001)(31696002)(86362001)(2616005)(91956017)(66476007)(478600001)(558084003)(76116006)(36756003)(66946007)(4326008)(71200400001)(38070700005)(6486002)(66446008)(66556008)(8676002)(64756008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVRTcmVYc3VkK3RnM0ovWk52ZVBYTDAzZUpEM3hhcERkMDBHeTVaam9yQnRu?=
 =?utf-8?B?N3JLS1JBU3JjK0J0NHdKWExmVjU3dGtabExNZlhobnNkOGZjYk9ZQkJ1bDdW?=
 =?utf-8?B?Q3FqdHhOVTQ0a3JQZ2dYS0cwTGR5TVNocG85enhSeVdCbFp0WVcvQms2NXBD?=
 =?utf-8?B?QmRiNVBNU1JXajlMMVkzNGJTbGsxbUN0azhrS0xvdVVDbVprS1RGM3pKaDdJ?=
 =?utf-8?B?T1Zpb2hVU0RTSFFsYm9Zdjg4YVp2dzY0R0dpU2VSS1JOMmlBcHNMdWdwZFFs?=
 =?utf-8?B?Y2t2dkI5Uk9VRjNtMGEycW5ybzVnWlFUeXBhU1MxVFBRTElISitqKzhsYUl6?=
 =?utf-8?B?OTlhcFBGc2xDQk4zdStqamlWSk9PSUdhcFVUV3NidFlHYjFzaXI2eTdXN2lL?=
 =?utf-8?B?SjNWNlByR2N1V0ViR3FuRUowNDRIejRwMnJpMWRxdGlXWnZEUTdwbkxaUmNS?=
 =?utf-8?B?YnlwTU9wNVA1MjZvVmovMTVTMXI5a2JnT0xWR09uaHQ2RUk3MHZjZjMrSWF5?=
 =?utf-8?B?UTZvUGxxa3d4amRuZnlKanN1V1lnZndVOHdDdE9PakF4N3ZweTYybkZLV3Fx?=
 =?utf-8?B?UlM4dFVnVmVlRjRWdC96MDlQMzU1K2JNVVZmV0c0cmEzNjVBUmRtYjR6MWI2?=
 =?utf-8?B?aUltZk1mV3JnY0UrbFBqUDdDV0pnVzE3T2ltRVhoVFdjZjRPUDhOYnRJdGI4?=
 =?utf-8?B?eWtrdVRQeHpidjk3MHRsSGZPSHcwek9KWDVZQkpkRjJ6TVBSZGdnWUtzT0Va?=
 =?utf-8?B?azMrQ0MzWVZIRG4xSTJEMFp1UCs1WTg4YjI5RUwrSENGTmQ0czhoSFZJVUZM?=
 =?utf-8?B?UG1aUUVteDR3bmx6STg5TllGWkVWYjgwbTBWL2Y3dDVzcU94NnJEa3hrUVgz?=
 =?utf-8?B?U0JNZlNVbXhGTXJFbFV4TWh4RUlSUnduamM1SGQ1U1g2YmZDQzZJUzZmTmlY?=
 =?utf-8?B?SU1qVDlQN3A0S3hIc3hVanZhVDNscVhPZVhlYVM2Rkczd21MTWhTb3VvUEEy?=
 =?utf-8?B?Wk1RZ1lrUnVRS21aTVdSTmhJcUJVL3JBOHVQa2pwdENhMUt6UFg3blgxQUMv?=
 =?utf-8?B?b2ZuQUlkcGdldFcxbEFtVU1YU3NXVDdid1ZJQjlnaXkzM0hRbEJOVUlLVDBh?=
 =?utf-8?B?cm5WWVpERnVNWmNKb2ZoenZXMndCcy9FZWxzM3ZpSmRJV0pHOXFvOWdhbEdL?=
 =?utf-8?B?WGlhVHl1SlQ1NE9mSjF4L0ZRNWF2QnNDd3poRnVES2lnVVk1TzAvZ1ZucHFa?=
 =?utf-8?B?QzROWm05VDhmV0RXZGQ2QWJqbVluL1pZcWpGOEZxdEVvRjdrOVh2YjBJMEZ5?=
 =?utf-8?B?bnNwdjFRM1A5YmVhNGduTGhFVXN3cThpdkxmRGZmVnA5SjVac1VDMHFvaU96?=
 =?utf-8?B?WEFWY2ZKRHlhZTJMbmowYWFqMEtUMTNXczJWRFIrUWl2RUM2WWZUUk01Z2pq?=
 =?utf-8?B?bi9lM1JtdlppN3JlbGlPOGNrV1JZOVl0L2h0c3dnR2Q3dEpiQWNhSlhmaXlY?=
 =?utf-8?B?d2ZhNGZ6UmR2M0ZsRWNyTjlrdmYzUzJrMjBsd2Q0UStIaHJITXVsRFhXL3lZ?=
 =?utf-8?B?QmFhK1pIc0pmRXkvc1NpUTJBNGl2UTM2VGY0N0g0dFJ2aDZQcldpMGhoS1Rr?=
 =?utf-8?B?Yk5RLzdldmtReVBRNFhKT1FLNldubllpWmltNGFNNkpUNGtYeDZnaFkySndu?=
 =?utf-8?B?VlJYOFZJc1c4c0pVUzA5alQ5OWhHc1lMOXFYWnNYdFdRMmFtSmRXN1ZSL3k3?=
 =?utf-8?B?bWxMSXQ3ZkFvVW5OVk01TkhyZHJLbVZXazh0QmExMTJSZnFHZm45SzZsNkNG?=
 =?utf-8?B?bDV6SU50cDlnUmluai9BekdGTmEyUUlzclJlb1dFeTNxZGpWZkJCMnRCakVB?=
 =?utf-8?B?V3FZVDZYMDdxR0NYQnYzYnptYnlwcDFpNTBFVXVURldtR0JsV2ErVVgyYTZN?=
 =?utf-8?B?djM0Z1pZK1RvRjNuY1Buc1lCS2xCWUdnWGhFejl4Z1I1b2M5dnp1bUovb2pT?=
 =?utf-8?B?NjB0L2hDcjZRNzYrVEpiS096UHpQUXh5TXZSdmJNMUkzUkUya0twbTc5L3VL?=
 =?utf-8?B?dis5dCtZWW9MU21HTUd2UmN2Qk81aHd6N2xwRTNySlhMQzVSdUYrMjlGWG1H?=
 =?utf-8?B?YVhIb3M5UFNOSkkzQjR2OXRTMzdZWmpkWlU4MS9IZDVVTG5pTGZDTDAyVyty?=
 =?utf-8?B?YUFtNWU5T3I2akRGSkFxM3lYcFQ3cXpGODhSWjlUbVB3OWpnV08xTmlqUTlp?=
 =?utf-8?Q?wG47Z6n1swH/qhDD85XRlf2c2GU9PWo+bCj/nS4oZI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <721B368B685F784EA493D5E5DC590BAC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pOdkvLC88s7mDDn+dw0uxA8M1JEfTvFvHlJKVL9IRkOts8EZcbDaKjMFg0WFR/OUqcZy61ckSS++DNVEn0jup3nAliF2ZLHLoWrt4XxEnfbS8s2twOLXiBYAVL91bGPEhmH2EPxB5iuF9yhvizUebKLqKCAoN5qlVVob6ZDG1gToxEzRv1cCCbiUeuO8IWbFLzdBcndcPI/YUqrNmEh9v0zWgbMgLhI+hbrCftkYF3kLP/MOt/SFgekmx1NbTkAhbrwHq9tJdAo5dZFZ8RIIDFqg7DJDvSqha32t5UaW9PfysNnQFpoOW9NKitNX3aAqLmPYG7/aDwt1I9NnmX++/kzfqdpBEDnOAEbv1/0tZmmb+SSCgtvXcYA3N5QYNC8DVBExb+oDJLOSGsxlfGMGCTvuuguy//nvx6sf8hWP3ZIhTd4iOJqlsezE1FF7emg+0IBhXFjeJ4+lSybDFa/VDQHDsCVDrygVkhsQUZ/p10U7DookzQgcdb5ptXQwQoGG/qMywdmhbncQWVstd2A+PIEZBVlv9llFZiYjX8vT4Mwx19A+dY/8jv61D7OB6pU1AGLPY3S3oz2hzHQeuvV4yEXFWjSoWoIZW8u1rQYOYumwAo0P5JAPHBWPWnX55VDn+6y3h9tz+cf0twcNPQIHJdgGQhIPlMPKW+LnYCEoMYVmloJ3bysYh1JN2oeZ+Gq/iaJ5eRUpDS1nzlAOH7tinhFIpo/O2+D4BvbQeXU7f3+UShBQ3OBVwnVb235LiLt/jQTXMPnDqtSEx9pCKd/IixJDOcigVfx53scPpMu8QvqTER8AZN9JaPJLs/WTwgHU3yzR4Zdzk2w4Ah7uKBcT4oSJcOgRwxb8GlTObGJw/EzW5o7tculBklFokC1+EjpY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaae5901-e1d1-416f-d3d1-08db0b574b47
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 11:09:35.5803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dGe6Q1TeiGnezMkYBQwg8xa3vgSl2rz0g7yYhOorgOeBI2ncyCmiR1hbThTqS6xerHsbV6Gqcu8NvntOVqxM2P4d0uLObv0pfzbALV7wLD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6121
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTAuMDIuMjMgMDg6NDksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KDQpzL2VtYmVkZGVk
L2VtYmVkLyBpbiAkc3ViamVjdA0KDQo+IEVtYmVkZCBhIGJ0cmZzX2JpbyBpbnRvIHN0cnVjdCBj
b21wcmVzc2VkX2Jpby4gIFRoaXMgYXZvaWRzIHBvdGVudGlhbA0KDQpzL0VtYmVkZC9FbWJlZC8N
Cg0KDQo=
